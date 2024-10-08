region = "ap-southeast-2"
acm_certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/xyz01ef7-f64d-427a-9b5c-5517d546d6a0"
route53_domain = "{{project_id}}.example.com"
route53_zone_id = "xyz296912JG7GZKGUIPJI"
s3_bucket_cdn_log = "{{project_id}}-cdn-log"
s3_bucket_site = "{{project_id}}.example.com"
enable_s3_bucket_extras = true
s3_bucket_extras = "{{project_id}}.example.com-extras"
enable_lambda_viewer_request = true
lambda_viewer_request_arn = "arn:aws:lambda:us-east-1:123456789012:function:serverlessrepo-wehr-enter-LambdaAuthorizerBasicAut-xyzuW5BxvLWY:1"
enable_lambda_origin_request = true
lambda_origin_request_arn = "arn:aws:lambda:us-east-1:123456789012:function:serverlessrepo-digital-sa-StandardRedirectsForClou-xyzGK4EUES3T:1"
