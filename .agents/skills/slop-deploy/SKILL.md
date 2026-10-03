---
name: slop-deploy
description: Deploy or redeploy small static frontend applications to Cloudflare Workers under slop.chrisboulton.com using the personal Wrangler profile. Use for slop-deploy requests or publishing prototypes to this domain; server runtime conversions are outside its scope.
---

# Slop Deploy

Publish the application in the current working directory to `https://<app-name>.slop.chrisboulton.com`. Keep the workflow small: inspect, build, deploy, verify.

## Target and authorization

Unless the user explicitly overrides the target, derive the app name from the current directory's basename, use Worker `slop-<app-name>`, and assign Custom Domain `<app-name>.slop.chrisboulton.com`. Repeated deployments update the same Worker; use stable names without timestamps or random suffixes.

Accept an explicit name such as `$slop-deploy ibis` or `/slop-deploy ibis`. Normalize to lowercase ASCII letters, digits, and hyphens: replace spaces, underscores, and separators with hyphens, remove unsupported characters, collapse repeated hyphens, and trim leading/trailing hyphens. Ask for a name if the result is empty, invalid for the hostname or Worker, or changes the meaning substantially; avoid silent truncation.

Always use Wrangler authentication profile `personal`. Never fall back to the default profile. Check that the selected Wrangler version supports `--profile`; resolve a version limitation without changing the authentication target. Authenticated commands must select `personal` wherever supported. Preserve intentional account configuration and resolve any conflict with the personal target before deployment.

A request to deploy authorizes normal creation or updating of this application's Worker and Custom Domain. Loading this skill during planning or review does not itself authorize publishing. Deploy the current working tree, including uncommitted work; a clean Git state is unnecessary. Commit only when requested.

## Inspect and prepare assets

Inspect existing `wrangler.jsonc`, `wrangler.json`, or `wrangler.toml`, package scripts, lockfiles, framework/build configuration, and application routing. Identify the actual public asset directory and whether client-side navigation needs an `index.html` fallback.

- For a plain HTML/CSS/JavaScript site, use its static files directly. If the repository root includes private or unrelated files, stage only the intended public files in a dedicated asset directory, preserving relative paths and required resources.
- For a frontend build, run the existing build script with the project's package manager. Prefer declared package-manager settings; otherwise infer from `pnpm-lock.yaml`, `yarn.lock`, `bun.lock`/`bun.lockb`, or `package-lock.json`. Install dependencies only when needed. Determine output from configuration or build results, rather than assuming `dist`, `build`, `out`, or `public`.
- Preserve an intentional Workers setup and its deployment/build integration where possible. A new server runtime, SSR adapter, database, Durable Objects, queues, or other bindings are outside the automatic static-assets path. Explain an incompatible requirement rather than converting the architecture.

Before publishing, inspect the actual upload directory for accidental exposure, including `.env*`, `*.pem`, `*.key`, credentials/secrets files, `.wrangler/`, `.git/`, and `node_modules/`. Frontend build variables become public when bundled into JavaScript; framework prefixes do not make credentials safe. If the build requires embedding sensitive credentials, stop and explain the issue. Public frontend configuration is acceptable.

## Configure Workers

Use Workers static assets and a Worker Custom Domain. For new configuration, prefer persistent `wrangler.jsonc` so redeployment is straightforward. An assets-only Worker needs neither project scaffolding nor a JavaScript entrypoint.

Preserve existing Wrangler configuration and make the smallest necessary changes. Resolve conflicts before changes that would significantly alter its semantics. Keep unrelated domains, bindings, and settings intact. Resolve asset paths relative to the configuration file.

For a newly configured static application, adapt this example, replacing the name, hostname, asset directory, and compatibility date with the selected target, actual output directory, and current date:

```jsonc
{
  "name": "slop-ibis",
  "compatibility_date": "YYYY-MM-DD",
  "assets": {
    "directory": "./dist"
  },
  "workers_dev": false,
  "routes": [
    {
      "pattern": "ibis.slop.chrisboulton.com",
      "custom_domain": true
    }
  ]
}
```

For a client-side SPA, add `"not_found_handling": "single-page-application"` under `assets`. Ordinary multi-page sites retain their normal routing. Use native asset handling rather than a custom JavaScript router.

The Custom Domain pattern is the bare hostname, without a scheme or `/*` suffix. Cloudflare manages its DNS and TLS certificate; no manual certificate setup is needed. Disable `workers.dev` when creating new configuration.

When version-specific behavior is uncertain, consult installed Wrangler help/schema and the relevant official documentation:

- [Wrangler configuration](https://developers.cloudflare.com/workers/wrangler/configuration/) for configuration fields.
- [SPA asset routing](https://developers.cloudflare.com/workers/static-assets/routing/single-page-application/) for fallback behavior.
- [Custom Domains](https://developers.cloudflare.com/workers/configuration/routing/custom-domains/) for hostname setup and DNS conflicts.
- [Wrangler general commands](https://developers.cloudflare.com/workers/wrangler/commands/general/) for authentication commands.

## Deploy and handle conflicts

Once the build succeeds, assets are appropriate for public upload, and configuration matches the target, deploy:

```bash
npx wrangler deploy --profile personal
```

Retain `--profile personal` if additional configuration flags or an existing deployment integration are required.

If the hostname belongs to a different Worker or unrelated resource, stop and ask before takeover. If an incompatible DNS record blocks deployment, inspect its association. Replace or remove it only when it is clearly from an earlier deployment of this same application or the user explicitly authorizes the change. Scope every mutation to this application; deletion of other Workers, unrelated DNS records/resources, zone changes, and account-wide settings require separate authorization.

On failure, retain useful error details and diagnose authentication, account/zone permissions, target conflicts, build failure, asset paths, or incompatible configuration. Retry deployment only after identifying and correcting a specific cause. If the same failure recurs after the correction, stop and report the blocker; avoid blind redeployments or repeated infrastructure changes.

## Verify and report

Verify the canonical HTTPS URL, not just Wrangler's exit status:

- DNS resolution and TLS validation succeed.
- The root responds successfully and its content matches the built application, rather than an unrelated site or Cloudflare error page.
- For an SPA with an identifiable non-root route, verify that route as a browser navigation. When using an HTTP client, send `Sec-Fetch-Mode: navigate` to exercise navigation fallback.

For DNS or certificate provisioning delays, retry read-only HTTPS checks up to five times, with waits of at most 30 seconds. Keep TLS validation enabled. If verification still fails, report that Cloudflare accepted the deployment but the endpoint remains unverified, including the observed blocker. Provisioning delays do not justify redeployment or DNS replacement.

Report success only after HTTPS verification passes. Return a concise result with the Worker name and clickable canonical URL, for example: `Deployed slop-ibis:` followed by `https://ibis.slop.chrisboulton.com`. Mention local configuration changes or a remaining blocker when useful.
