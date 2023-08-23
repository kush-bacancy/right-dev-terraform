resource "aws_ecs_cluster" "aws-ecs-cluster" {
  name = "${var.prefix}-ms-cluster"
}
resource "aws_ecs_service" "aws-ecs-service" {
  name                 = var.prefix
  cluster              = aws_ecs_cluster.aws-ecs-cluster.id
  launch_type     = "EC2"
  task_definition      = aws_ecs_task_definition.task_definition.arn
  #scheduling_strategy  = "REPLICA"
  desired_count        = 1
  force_new_deployment = true

  network_configuration {
    subnets          = [aws_subnet.pub_sub1.id,aws_subnet.pub_sub2.id]
    assign_public_ip = true
    security_groups = [
      aws_security_group.elb_sg.id,aws_security_group.webserver_sg.id
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.TG.arn
    container_name   = "AdeptMsAdeptCourseTerraform"
    container_port   = 80
  }
}




