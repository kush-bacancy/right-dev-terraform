resource "aws_ecs_task_definition" "task_definition" {
  container_definitions    = data.template_file.task_definition_json.rendered # task defination json file location
  family                   = "AdeptMsAdeptCourseTerraform"            # task name
  network_mode             = "bridge"                                         # network mode awsvpc, brigde
  memory                   = "512"
  cpu                      = "256"
  requires_compatibilities = ["EC2"] # Fargate or EC2
  task_role_arn = "arn:aws:iam::874427660032:role/ecsTaskExecutionRole"
  execution_role_arn = "arn:aws:iam::874427660032:role/ecsTaskExecutionRole"

}

data "template_file" "task_definition_json" {
  template = file("task_definition.json")

  vars = {
    CONTAINER_IMAGE = "nginx"
  }
}