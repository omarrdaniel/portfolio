---
title: "L3/L4 Anti-DDoS via BGP Routing and Cloudflare Magic Transit"
sector: "Transport / road infrastructure, Italy"
role: "Cloud Network & Security Consultant"
stack: ["Cloudflare Magic Transit", "BGP", "GRE Tunnels", "WAF"]
summary: "Protected network-layer infrastructure against L3/L4 DDoS using BGP-routed traffic through Cloudflare Magic Transit over GRE tunnels, then migrated B2B/B2C applications onto Cloudflare with caching, WAF, and anti-bot."
order: 3
---

## Context

The client operates transport and road infrastructure systems where network-layer availability is critical. The existing setup had no dedicated network-layer DDoS protection, and B2B/B2C applications were running without modern edge security.

## What I did

- Designed and implemented L3/L4 anti-DDoS protection using BGP route announcement into Cloudflare Magic Transit, so traffic gets scrubbed at Cloudflare's edge before it ever reaches client infrastructure
- Set up GRE tunnels to carry clean traffic back from Cloudflare to the client's network after DDoS mitigation
- Migrated B2B and B2C applications onto Cloudflare separately from the network-layer work, introducing caching, WAF, and anti-bot protection as part of that migration

## Outcome

- Network-layer traffic now has DDoS scrubbing in front of it by design, instead of relying on absorbing attacks with on-premises capacity
- B2B/B2C applications gained WAF and anti-bot coverage they didn't have before, on top of the availability benefits of caching at the edge
- Two previously separate concerns — network-layer resilience and application-layer security — now sit on the same platform, simplifying who the client's team talks to when something needs adjusting

*Client name withheld per confidentiality agreement. Architecture and outcomes described are accurate; identifying details have been generalized.*
