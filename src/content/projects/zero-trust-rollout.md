---
title: "Zero Trust Access Rollout for a Financial Services Client"
sector: "Financial services, EU"
role: "Cloud Network & Security Consultant"
period: "2025 – 2026"
stack: ["Cloudflare Zero Trust", "Palo Alto NGFW", "Azure AD", "SASE"]
summary: "Replaced legacy VPN-based access for internal applications with a Zero Trust access model, phased across business units to avoid disruption."
order: 2
---

## Context

The client relied on a traditional site-to-site VPN for employees and third-party contractors to reach internal applications. This gave broad network-level access rather than per-application access, and the VPN concentrator itself was becoming a recurring operational bottleneck during high-load periods.

## What I did

- Designed a Zero Trust Network Access (ZTNA) architecture to replace VPN access for internal web applications, integrating identity-based policies with the client's existing Azure AD directory
- Worked directly with the vendor's solutions team to align the rollout with platform roadmap features still in early access
- Defined a phased migration plan by business unit to avoid a disruptive "big bang" cutover, starting with lower-risk internal tools before moving to sensitive financial systems
- Coordinated with the client's network team to retire legacy firewall rules and VPN concentrator capacity as each phase completed
- Ran technical workshops with the client's security team to hand over policy management, so they could maintain and extend the model independently after go-live

## Outcome

- Per-application, identity-aware access replaced broad network-level VPN access for the migrated business units
- Removed a long-standing operational bottleneck tied to VPN concentrator capacity during peak usage
- Client security team fully capable of managing and extending the Zero Trust policy set without ongoing vendor support

*Client name withheld per confidentiality agreement. Architecture and outcomes described are accurate; identifying details have been generalized.*
