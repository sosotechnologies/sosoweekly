resource "aws_iam_user" "user" {
  name = var.iam_username
  tags = merge(map(
    "Name", var.iam_username,
    "Environment", var.env
  ), var.base_tags)
}

resource "aws_iam_user_policy_attachment" "attach" {
  user = aws_iam_user.user.name
  policy_arn = var.iam_policy_arn
}
#---
