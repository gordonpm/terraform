resource "aws_eks_cluster" "main" {
  
  name     = local.eks_cluster_name
  
  version  = var.cluster_version
  
  role_arn = aws_iam_role.eks_cluster.arn

  # VPC configuration for control plane networking
  vpc_config {
    subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnet_ids
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
  }

  # Define the service CIDR range used by Kubernetes services (optional)
  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  # Enable EKS control plane logging for visibility and debugging
  enabled_cluster_log_types = [
    "api",                 
    "audit",               
    "authenticator",       
    "controllerManager",   
    "scheduler"            
  ]

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller
  ]

  tags = var.tags

  # ----------------------------------------------------------------------------
  # Access Config – How we control who can access our EKS cluster
  #
  # authentication_mode = "API_AND_CONFIG_MAP"
  # → This means we are using both methods:
  #    1. The old way (aws-auth ConfigMap) – still works for all our demos
  #    2. The new way (Access Entries API) – future-proof for AWS direction
  #
  # bootstrap_cluster_creator_admin_permissions = true
  # → This makes sure the person who creates the cluster (you, running Terraform)
  #   automatically gets admin (cluster-admin) access.
  #   If this was false, no one would have access until we manually set it up.
  #
  # ----------------------------------------------------------------------------
  access_config {
    authentication_mode = "API_AND_CONFIG_MAP" # Three options: CONFIG_MAP, API, API_AND_CONFIG_MAP
    bootstrap_cluster_creator_admin_permissions = true
  }

}


