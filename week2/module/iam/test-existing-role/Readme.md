<!-- https://www.lewuathe.com/how-to-add-new-policy-to-iam-role.html

/*How to add new policy to IAM role by Terraform
Because Policies are standalone entities and are useless unless attached to a role or user. I will create a role that the policy will assume.
the aws_iam_role_policy I will create attached to my-role does not have any name specified.
*/
# create role 


You can attach the existing policy to the existing IAM role. That indicates we can reuse the policy by attaching it to several roles. -->