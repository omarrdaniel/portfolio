---
title: "WAF & CDN Consolidation for a Multi-Brand Retail Group"
sector: "Retail / e-commerce, EU"
role: "Cloud Network & Security Consultant"
period: "2025"
stack: ["Cloudflare", "F5 Distributed Cloud", "Terraform", "CI/CD"]
summary: "Consolidated fragmented WAF/CDN configurations across multiple e-commerce brands into a single, policy-driven edge security layer."
order: 1
---

## Context

The client — a European retail group operating several independent e-commerce brands — had grown through acquisitions. Each brand ran its own ad-hoc WAF and CDN configuration, managed by different teams with inconsistent rule sets. This created blind spots during traffic spikes (seasonal sales) and made incident response slow, since no one had a single view of edge security posture across brands.

## What I did

- Audited existing WAF/CDN configurations across all brand properties to map inconsistencies and gaps in rule coverage
- Designed a consolidated Cloudflare + F5 Distributed Cloud architecture with shared baseline WAF rulesets, brand-specific overrides layered on top
- Migrated DNS, CDN caching rules, and Anti-DDoS policies brand-by-brand with zero-downtime cutovers, coordinating maintenance windows with each brand's engineering team
- Automated the whole configuration via Terraform, replacing manual dashboard changes with version-controlled, peer-reviewed infrastructure code
- Set up centralized alerting so security events across all brands surface in one place instead of per-brand silos

## Outcome

- Single source of truth for edge security configuration across the group, with changes now going through pull request review instead of ad-hoc dashboard edits
- Faster incident response during peak traffic events, since the team could finally see cross-brand patterns instead of investigating each property in isolation
- Onboarding a new brand onto the shared baseline now takes hours instead of the multi-week manual process it used to be

*Client name withheld per confidentiality agreement. Architecture and outcomes described are accurate; identifying details have been generalized.*
