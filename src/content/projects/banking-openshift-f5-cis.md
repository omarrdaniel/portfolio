---
title: "OpenShift Bare-Metal Migration with F5 Container Ingress Services"
sector: "Banking, Italy"
role: "Cloud Network & Security Consultant"
stack: ["F5 BIG-IP", "F5 CIS", "OpenShift (OCP)", "Kubernetes"]
summary: "Designed and validated a dynamic BIG-IP/CIS integration for a bank's migration from virtualized OpenShift clusters to bare-metal OCP, then supported the live cutover."
order: 1
---

## Context

The client, an Italian bank, was migrating its OpenShift Container Platform clusters from a virtualized environment to bare metal, for performance and operational reasons. The networking and ingress layer had to move with it: BIG-IP sits in front of the cluster and needs to track pod-level changes automatically as workloads scale, restart, or move, rather than through manual reconfiguration every time the cluster state changes.

## What I did

- Built and ran lab environments to validate F5 Container Ingress Services (CIS) integration patterns before touching anything client-facing, testing how BIG-IP should respond to Kubernetes pod lifecycle events
- Designed the architecture so BIG-IP configuration, pool members, health monitors, and virtual servers, updates dynamically via CIS as pods in the Kubernetes cluster scale up, scale down, or get rescheduled, instead of relying on manual or semi-manual updates
- Supported the live implementation phase directly with the client's platform team during the bare-metal cutover
- Owned migration troubleshooting end to end: diagnosing discrepancies between expected and actual BIG-IP state during cutover windows, and resolving CIS-to-cluster synchronization issues as they came up

## Outcome

- BIG-IP configuration became a live reflection of actual Kubernetes cluster state instead of a manually maintained approximation of it, removing a recurring source of configuration drift
- The migration path from lab validation to production cutover meant issues were caught and resolved before they affected the live environment, not during it
- Handed over a bare-metal ingress setup the client's own platform team could operate without depending on manual BIG-IP changes for routine pod-level changes

*Client name withheld per confidentiality agreement. Architecture and outcomes described are accurate; identifying details have been generalized.*
