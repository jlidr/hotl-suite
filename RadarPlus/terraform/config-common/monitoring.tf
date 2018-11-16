## Shows some example cloudwatch metric alarms. This example includes basic
## instance monitoring (status and CPU), and some different ELB alarms.

## We'll use SNS to send email notifications of cloudwatch alarms. This resource
## only creates the topic, it's up to the user to login to the SNS console and
## create the email notification to the topic. Terraform does not support
## creating email subscriptions to SNS topics.
resource "aws_sns_topic" "monitoring" {
  name = "monitoring-topic"
}

## Create cloudwatch alarms for instances. Since the `aws_instance.publicnode`
## resources uses the `az_count` variable to define its count, we'll use the
## same variable here.
resource "aws_cloudwatch_metric_alarm" "instance_cpu" {
  count = "${var.az_count}"
  alarm_name = "cpu_over_80"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Average"
  threshold = "80"
  alarm_description = "Alert on high CPU util"

  alarm_actions = ["${aws_sns_topic.monitoring.arn}"]

  dimensions {
    InstanceId = "${element(aws_instance.publicnode.*.id, count.index)}"
  }
}

resource "aws_cloudwatch_metric_alarm" "instance_status" {
  count = "${var.az_count}"
  alarm_name = "status_check"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "1"
  metric_name = "StatusCheckFailed"
  namespace = "AWS/EC2"
  period = "60"
  statistic = "Sum"
  threshold = "0"
  alarm_description = "Alert on status check failures"

  alarm_actions = ["${aws_sns_topic.monitoring.arn}"]

  dimensions {
    InstanceId = "${element(aws_instance.publicnode.*.id, count.index)}"
  }
}
