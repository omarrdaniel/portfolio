---
title: "Hub-and-Spoke Network Design on Azure with FortiGate & NGINX"
sector: "Luxury / fashion, EU"
role: "Cloud Network & Security Consultant"
stack: ["Microsoft Azure", "FortiGate NGFW", "NGINX", "Hub-and-Spoke"]
summary: "Designed a hub-and-spoke network architecture on Azure for a fashion group, with FortiGate as the centralized next-gen firewall and NGINX handling WAF duties at the application layer."
order: 6
---

## Context

A second engagement with a luxury/fashion group, focused on network architecture rather than application migration: the client needed a scalable, centrally-managed network design on Azure as their cloud footprint grew, rather than a flat or ad hoc network structure that gets harder to secure and operate as it expands.

## What I did

- Designed a hub-and-spoke network topology on Azure, centralizing shared network and security services in the hub while keeping workload-specific resources isolated in their own spokes
- Positioned FortiGate as the centralized Next-Generation Firewall in the hub, giving the client a single enforcement and inspection point for traffic moving between spokes and out to the internet
- Deployed NGINX as the WAF layer for application-layer protection, working alongside FortiGate's network-layer inspection rather than duplicating it

## Outcome

- New workloads can be onboarded into their own spoke without re-architecting network security each time, since the hub already provides the shared enforcement point
- Network-layer (FortiGate) and application-layer (NGINX WAF) security are clearly separated by function, making it easier to reason about where a given control lives
- The design gives the client a foundation that scales with additional spokes as the Azure footprint grows, instead of a topology that needs rework at the next expansion

*Client name withheld per confidentiality agreement. Architecture and outcomes described are accurate; identifying details have been generalized.*
