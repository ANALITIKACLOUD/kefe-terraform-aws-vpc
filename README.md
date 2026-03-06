# kefe-terraform-aws-vpc

Terraform module to provision VPC networking for EFE AWS accounts.

## RESUMEN

Reusable VPC module following EFE PRD architecture: private subnets + TGW subnets, no public subnets, no IGW, no NAT. All traffic exits via Transit Gateway.

## OVERVIEW

```mermaid
flowchart TB
    subgraph VPC["VPC CIDR 20"]
        subgraph AZa["AZ us-east-1a"]
            PRIa("Private subnet CIDR 24")
            TGWa("TGW subnet CIDR 28")
        end
        subgraph AZb["AZ us-east-1b"]
            PRIb("Private subnet CIDR 24")
            TGWb("TGW subnet CIDR 28")
        end
        subgraph AZc["AZ us-east-1c"]
            PRIc("Private subnet CIDR 24")
            TGWc("TGW subnet CIDR 28")
        end
        RTprivate["Route Table private"]
        RTtgw["Route Table tgw"]
        S3EP(["S3 Gateway Endpoint"])
    end

    TGW["Transit Gateway external"]
    OnPrem["On-prem network"]

    PRIa --> RTprivate
    PRIb --> RTprivate
    PRIc --> RTprivate
    TGWa --> RTtgw
    TGWb --> RTtgw
    TGWc --> RTtgw
    TGWa --> TGW
    TGWb --> TGW
    TGWc --> TGW
    RTprivate --> S3EP
    RTprivate -->|"default route + on-prem"| TGW
    TGW --> OnPrem
```

## Usage

```hcl
module "vpc" {
  source = "../../"

  prefix      = "kefe"
  project     = "data"
  environment = "dev"
  vpc_cidr    = "10.91.0.0/20"

  azs                = ["us-east-1a", "us-east-1b", "us-east-1c"]
  transit_gateway_id = "tgw-0d8bbe277bfa6c109"
}
```

## Migration pilot to production

1. Change `prefix` from `kefe` to `efe` in tfvars
2. Update backend.hcl to point to EFE GHE state bucket
3. Update OIDC provider in workflows to EFE GHE
4. `terraform plan` shows tag renames only, zero destroy

## CONTEXT

- Based on real PRD VPC (505181271348): 10.90.0.0/20, 2 AZs, 4 subnets, no public, no NAT, all TGW
- Improved: 3 AZs (vs 2 in PRD) for higher resilience
- Conditional TGW: if transit_gateway_id is empty, TGW routes are skipped (useful for testing in accounts without TGW)
