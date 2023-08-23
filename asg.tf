#Create Launch config
resource "aws_launch_configuration" "webserver-launch-config" {
  name_prefix   = "webserver-launch-config"
  image_id      =  var.ami
  instance_type = "c5.xlarge"
  key_name = var.keyname
  security_groups = ["${aws_security_group.webserver_sg.id}"]

  root_block_device {
    volume_type = "gp2"
    volume_size = 10
    encrypted   = true
  }
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = 5
    encrypted   = true
  }
  lifecycle {
    create_before_destroy = true
  }
  user_data = "#!/bin/bash\necho ECS_CLUSTER=adept-ms-cluster >> /etc/ecs/ecs.config"
}

# Create Auto Scaling Group
resource "aws_autoscaling_group" "ASG" {
  name       = "${var.prefix}-asg"
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  force_delete       = true
  depends_on         = [aws_lb.ALB-tf]
  target_group_arns  =  ["${aws_lb_target_group.TG.arn}"]
  health_check_type  = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier = ["${aws_subnet.prv_sub1.id}","${aws_subnet.prv_sub2.id}"]

  tag {
    key                 = "Name"
    value               = "${var.prefix}-asg"
    propagate_at_launch = true
  }
}

# Create Target group
resource "aws_lb_target_group" "TG" {
  name     = "${var.prefix}-target_group"
  depends_on = [aws_vpc.main]
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.main.id}"
}

# Create ALB
resource "aws_lb" "ALB-tf" {
  name              = "${var.prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups  = [aws_security_group.elb_sg.id]
  subnets          = [aws_subnet.pub_sub1.id,aws_subnet.pub_sub2.id]
  tags = {
    name  = "${var.prefix}-alb"
    Project = var.prefix
  }
}
# Create ALB Listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.ALB-tf.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
}
resource "aws_autoscaling_schedule" "start_schedule" {
  scheduled_action_name = "start-schedule"
  min_size              = 1
  max_size              = 4
  desired_capacity      = 1
  recurrence            = "45 6 * * MON-FRI"
  autoscaling_group_name = aws_autoscaling_group.ASG.name
}

resource "aws_autoscaling_schedule" "stop_schedule" {
  scheduled_action_name = "stop-schedule"
  min_size              = 0
  max_size              = 0
  desired_capacity      = 0
  recurrence            = "0 19 * * MON-FRI"
  autoscaling_group_name = aws_autoscaling_group.ASG.name
}
