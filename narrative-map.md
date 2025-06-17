# Narrative Map

## Timeline

- `6c327717966`: chat - wire alternative provider into auth service call
- `47ad82a6cdb`: add JGWILL build/setup scripts and ledger infrastructure
- d348af3ea6f: rename product to WillCode
- _next commit_: prepare packaging docs and fix build script
- ce021a71e21: applying previous commit (docs site, packaging tweaks)
- [current]: harden build and setup scripts
- _next_: improve build automation and install system libs

## Summary

This branch evolves the VSCode fork into a customizable build. Initial upstream commit sets authentication service improvement. Our new commit introduces automation for building the project and capturing logs for failures. It also adds a ledger system for agent collaboration.
The newest iteration rebrands the application as WillCode, ensuring packaging and executable names match the fork's identity. Following commits prepare distribution metadata with our custom documentation URL and refine build failure handling.
This update hardens the automation so setup does not abort on package failures and build logs upload gracefully when the `coaia` tool is missing.
Latest changes attempt npx-based gulp execution and ensure system libraries are installed to support native modules.
