# Define the Route 53 Hosted Zone
resource "aws_route53_zone" "varsha_mediswift_zone" {
  name = "varsha-mediswift.com"
}

# A record for the root domain pointing to the frontend Load Balancer
resource "aws_route53_record" "root_domain" {
  zone_id = aws_route53_zone.varsha_mediswift_zone.zone_id
  name    = "varsha-mediswift.com"
  type    = "A"
  alias {
    name                   = "dualstack.abd9f2caab1484b0e8b17d43813e5981-1061278927.us-east-1.elb.amazonaws.com" # Load Balancer DNS Name
    zone_id                = "Z35SXDOTRQ7X7K" # Load Balancer Zone ID (you can find it in AWS documentation for your region)
    evaluate_target_health = true
  }
}

# CNAME record for www subdomain
resource "aws_route53_record" "www_subdomain" {
  zone_id = aws_route53_zone.varsha_mediswift_zone.zone_id
  name    = "www.varsha-mediswift.com"
  type    = "CNAME"
  ttl     = 300
  records = ["abd9f2caab1484b0e8b17d43813e5981-1061278927.us-east-1.elb.amazonaws.com"] # Load Balancer DNS Name
}