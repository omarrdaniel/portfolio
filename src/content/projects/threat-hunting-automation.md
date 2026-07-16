---
title: "Threat Hunting Framework with MITRE Caldera & STIX-Shifter"
sector: "Research / open source"
role: "Thesis Intern"
period: "2024"
stack: ["MITRE Caldera", "Python", "STIX-Shifter", "MITRE ATT&CK"]
summary: "Built a practical threat hunting framework using adversary emulation, and contributed fixes upstream to an open-source threat intel translation library."
order: 3
---

## Context

Threat hunting programs often stay reactive: teams react to alerts rather than proactively searching for adversary behavior that evades existing detection rules. My thesis work, done during an internship, tackled this by building a repeatable, technology-agnostic hunting methodology grounded in adversary emulation.

## What I did

- Designed and ran adversary emulation exercises using MITRE Caldera, mapping techniques to the MITRE ATT&CK framework to test detection coverage across multiple security tools
- Wrote Python automation to turn manual hunting playbooks ("huntbooks") into repeatable, scriptable procedures — reducing the manual effort needed for each hunting cycle
- Identified and fixed bugs in STIX-Shifter (an open-source library used to translate threat intelligence queries across different security platforms), specifically in the Sumologic, Elastic, and ReaQta connector modules
- Submitted the fixes upstream; the pull request was reviewed and merged into the main project

## Outcome

- A documented, repeatable threat hunting methodology validated across multiple technology stacks, used as the basis of my thesis
- Upstream open-source contribution now benefiting other STIX-Shifter users integrating with Sumologic, Elastic, or ReaQta
- Thesis graded as part of a 110/110 cum laude degree

[View the merged contribution on GitHub →](https://github.com/omarrdaniel)
