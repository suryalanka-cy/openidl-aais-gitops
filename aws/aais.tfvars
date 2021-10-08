#aais, analytics or aais dummy carrier should be carrier and for rest specify any org name: example for travelers: trv or travelers etc.
org_name = "aais" # For aais set to aais, for analytics set to analytics, for carriers set their org name, ex: travelers
aws_env = "test" #set to dev|test|prod
#--------------------------------------------------------------------------------------------------------------------
#Application cluster VPC specifications
app_vpc_cidr           = "172.26.0.0/16"
app_availability_zones = ["us-west-2a", "us-west-2b"]
app_public_subnets     = ["172.26.1.0/24", "172.26.2.0/24"]
app_private_subnets    = ["172.26.3.0/24", "172.26.4.0/24"]

#-------------------------------------------------------------------------------------------------------------------
#Blockchain cluster VPC specifications
blk_vpc_cidr           = "172.27.0.0/16"
blk_availability_zones = ["us-west-2a", "us-west-2b"]
blk_public_subnets     = ["172.27.1.0/24", "172.27.2.0/24"]
blk_private_subnets    = ["172.27.3.0/24", "172.27.4.0/24"]

#--------------------------------------------------------------------------------------------------------------------
#Bastion host specifications
#bastion hosts are placed behind nlb. These NLBs can be configured to be private | public to serve SSH.
#In any case whether the endpoint is private|public for an nlb, the source ip_address|cidr_block should be enabled
#in bastion hosts security group for ssh traffic

bastion_host_nlb_external = "true"

#application cluster bastion host specifications
app_bastion_sg_ingress =  [
  {rule="ssh-tcp", cidr_blocks = "172.26.0.0/16"},
  {rule="ssh-tcp", cidr_blocks = "3.237.88.84/32"}]
app_bastion_sg_egress  =   [
  {rule="https-443-tcp", cidr_blocks = "0.0.0.0/0"},
  {rule="http-80-tcp", cidr_blocks = "0.0.0.0/0"},
  {rule="ssh-tcp", cidr_blocks = "172.26.0.0/16"}] #additional ip_address|cidr_block should be included for ssh

#blockchain cluster bastion host specifications
#bastion host security specifications
blk_bastion_sg_ingress =  [
  {rule="ssh-tcp", cidr_blocks = "172.27.0.0/16"},
  {rule="ssh-tcp", cidr_blocks = "3.237.88.84/32"}]
blk_bastion_sg_egress  = [
  {rule="https-443-tcp", cidr_blocks = "0.0.0.0/0"},
  {rule="http-80-tcp", cidr_blocks = "0.0.0.0/0"},
  {rule="ssh-tcp", cidr_blocks = "172.27.0.0/16"}] #additional ip_address|cidr_block should be included for ssh

#--------------------------------------------------------------------------------------------------------------------
#Route53 (PUBLIC) DNS domain related specifications (domain registrar: aws|others, registered: yes|no)
domain_info = {
  r53_public_hosted_zone_required = "yes" # yes | no
  domain_name = "aaistrail.com", #primary domain registered
  sub_domain_name = "demo" #sub domain #
  comments = "aais node dns name resolutions"
}
#-------------------------------------------------------------------------------------------------------------------
#Transit gateway  specifications
tgw_amazon_side_asn = "64532" #default is 64532

#--------------------------------------------------------------------------------------------------------------------
#Cognito specifications
userpool_name                = "openidl"
client_app_name              = "openidl-client"
client_callback_urls         = ["https://openidl.aais.test.demo.aaistrail.com/callback", "https://openidl.aais.test.demo.aaistrail.com/redirect"]
client_default_redirect_url  = "https://openidl.aais.test.demo.aaistrail.com/redirect"
client_logout_urls           = ["https://openidl.aais.test.demo.aaistrail.com/signout"]
cognito_domain               = "aaistrail" #unique domain name
email_sending_account        = "COGNITO_DEFAULT" # Options: COGNITO_DEFAULT | DEVELOPER
# COGNITO_DEFAULT - Uses cognito default and SES related inputs goes to empty in git secrets
# DEVELOPER - Ensure inputs ses_email_identity and userpool_email_source_arn are setup in git secrets

#--------------------------------------------------------------------------------------------------------------------
#Any additional application specific traffic to be allowed in app_vpc
app_eks_workers_app_sg_ingress = [
  {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    description = "inbound https traffic"
    cidr_blocks = "172.27.0.0/16"
  },
   {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    description = "inbound https traffic"
    cidr_blocks = "172.26.0.0/16"
   }]
app_eks_workers_app_sg_egress = [{rule = "all-all"}]

#Any additional application specific traffic to be allowed in blk_vpc
blk_eks_workers_app_sg_ingress = [
  {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    description = "inbound https traffic"
    cidr_blocks = "172.27.0.0/16"
  },
   {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    description = "inbound https traffic"
    cidr_blocks = "172.26.0.0/16"
  }]
blk_eks_workers_app_sg_egress = [{rule = "all-all"}]

#--------------------------------------------------------------------------------------------------------------------
#application cluster EKS specifications
app_cluster_name              = "app-cluster"
app_cluster_version           = "1.21"

#--------------------------------------------------------------------------------------------------------------------
#blockchain cluster EKS specifications
blk_cluster_name              = "blk-cluster"
blk_cluster_version           = "1.20"

#--------------------------------------------------------------------------------------------------------------------
#cloudtrail related
cw_logs_retention_period = 90
s3_bucket_name_cloudtrail = "cloudtrail-logs"

#Name of the S3 bucket managing terraform state files
terraform_state_s3_bucket_name = "aais-test-tfstate-mgmt"

#Setting a random value to this variable will rotate password in AWS secret manager which may further required to update in VAULT instance
vault_password_reset = "set" #set a random string to this variable when password required to reset


