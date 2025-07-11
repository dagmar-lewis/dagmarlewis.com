#Create a role
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "ec2_role" {
  name = "app1-ec2-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}



#Attach role to policy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "custom" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  
}

#Attach role to an instance profile
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "app1-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_iam_policy" "s3_access_policy" {
      name        = "s3_access_policy"
      description = "Policy for accessing S3"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action   = ["s3:GetObject", "s3:ListBucket"]
            Effect   = "Allow"
            Resource = "arn:aws:s3:::${var.files_bucket_name}/*"
          },
          {
            Action   = "s3:ListBucket"
            Effect   = "Allow"
            Resource = "arn:aws:s3:::${var.files_bucket_name}"
          }
        ]
      })
    }


resource "aws_iam_role_policy_attachment" "s3_attachment" {
      role       = aws_iam_role.ec2_role.name
      policy_arn = aws_iam_policy.s3_access_policy.arn
    }