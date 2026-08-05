---
title: "Multi-Cloud Connectivity: Oracle OCI to AWS via VPN"
sector: "Gambling / betting, EU"
role: "Cloud Network & Security Consultant"
stack: ["AWS", "Oracle Cloud Infrastructure (OCI)", "VPN", "Hub-and-Spoke"]
summary: "Set up VPN connectivity between Oracle Cloud Infrastructure and AWS, and managed routing within a new AWS hub-and-spoke architecture, as part of the client's multi-cloud network design."
order: 9
---

## Context

The client, operating in the gambling/betting sector, ran workloads across both Oracle Cloud Infrastructure (OCI) and AWS, and needed the two connected as part of a broader move to a hub-and-spoke network architecture on AWS.

## What I did

- Set up VPN connectivity between the client's OCI and AWS environments
- Designed and managed routing within the new AWS hub-and-spoke architecture, so traffic between OCI, AWS spokes, and the rest of the network follows a centrally managed path instead of point-to-point connections added ad hoc

## Outcome

- OCI and AWS environments connected through a single, defined VPN path rather than an unmanaged mix of connections
- Routing centralized in the hub-and-spoke design, so onboarding another spoke or cloud connection later doesn't mean re-deriving the routing logic from scratch

*Client name withheld per confidentiality agreement. Architecture and outcomes described are accurate; identifying details have been generalized.*
