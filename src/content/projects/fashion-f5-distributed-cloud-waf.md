---
title: "B2B/B2C Migration to F5 Distributed Cloud, Managed as Code"
sector: "Luxury / fashion, EU"
role: "Cloud Network & Security Consultant"
stack: ["F5 Distributed Cloud", "F5 Customer Edge", "Terraform", "WAF", "Azure ExpressRoute"]
summary: "Migrated all B2B and B2C applications onto F5 Distributed Cloud, introduced WAF and anti-bot protection, and deployed dual Customer Edge clusters for private service exposure with fault tolerance."
order: 2
---

## Context

The client, a luxury/fashion group, needed to consolidate its B2B and B2C application delivery onto F5 Distributed Cloud. Beyond the platform migration itself, the applications lacked several baseline security capabilities: WAF coverage, rate limiting, bot mitigation, and L7 DDoS protection weren't consistently applied across the estate. Part of the estate also included private, non-internet-facing services that needed a way into the F5 Distributed Cloud fabric without being exposed publicly.

## What I did

- Migrated the full set of B2B and B2C applications onto F5 Distributed Cloud
- Introduced WAF policies, rate limiting, anti-bot controls, and Layer 7 anti-DDoS protection as part of the same rollout, rather than as a separate follow-up phase
- Deployed two separate 3-node Customer Edge (CE) clusters, one on-premises on VMware, one on Azure, to expose private services into F5 Distributed Cloud without putting them directly on the internet
- Designed the two CE clusters to provide mutual fallback: if one site has a fault, traffic can still reach private services through the other, using direct connectivity over Azure ExpressRoute between the on-prem and Azure environments
- Set up automated web application scanning so newly onboarded applications get baseline security visibility without a manual review step each time
- Managed the entire configuration, application delivery, security policy, and Customer Edge infrastructure alike, through Terraform, so every change to production went through version-controlled, reviewable infrastructure code instead of direct dashboard edits
- Owned ongoing management and troubleshooting of the platform post-migration

## Outcome

- A previously inconsistent security posture across B2B/B2C applications became a single, uniform baseline applied through the same Terraform-managed pipeline
- Private services gained a path into F5 Distributed Cloud without direct internet exposure, with site-level fault tolerance built into the design instead of a single point of failure
- New application onboarding follows a repeatable, codified process instead of ad hoc configuration
- Security capabilities (WAF, rate limiting, anti-bot, anti-DDoS) that used to require separate tooling or manual setup are now part of the same managed platform and the same change process

*Client name withheld per confidentiality agreement. Architecture and outcomes described are accurate; identifying details have been generalized.*
