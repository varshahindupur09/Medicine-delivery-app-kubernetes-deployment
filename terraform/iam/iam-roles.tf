# EKS Node Role
resource "aws_iam_role" "eks_node_role" {
  name = "eks-node-role-mediswift"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AmazonEKSWorkerNodePolicy to the EKS Node Role
resource "aws_iam_role_policy_attachment" "eks_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach AmazonEKSCNIPolicy to the EKS Node Role
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
}

# Attach AmazonEC2ContainerRegistryReadOnly for ECR Pull Access
resource "aws_iam_role_policy_attachment" "ecr_read_only_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Attach CloudWatchLogsFullAccess to enable logging for EKS Nodes
resource "aws_iam_role_policy_attachment" "cloudwatch_logs_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# Output for EKS Node Role ARN (useful for referencing in other resources)
output "eks_node_role_arn" {
  value = aws_iam_role.eks_node_role.arn
  description = "ARN of the EKS Node Role"
}