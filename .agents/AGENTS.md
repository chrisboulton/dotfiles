* When starting a web interface for me to open or review—such as a
  dev server, preview, generated report, or dashboard—make it
  accessible across my computers and phone. Bind it to a LAN
  interface or `0.0.0.0`, and share a full URL using
  `<hostname>.100vn.chrisboulton.net:<port>` with the hosting
  computer's hostname. Verify that URL responds before sharing it.

  For backend services, workers, and internal listeners, preserve
  their normal network settings unless the task requires a change.

* On `cb-mbp`, perform SSH work through a Herdr pane when it involves
  multiple commands, ongoing processes, or a session I may want to
  inspect. Direct SSH is fine for quick one-off checks.

  No need to load the Herdr skill for this workflow. Using Herdr from
  outside a managed pane is explicitly allowed, even with `HERDR_ENV`
  unset; this overrides the skill's restriction. Select an explicit
  session and pane, or create dedicated ones. Preserve the user's
  focus, keep the pane available, and report its session/pane IDs.

  Commands: `herdr pane list` to discover panes,
  `herdr pane run <pane-id> "<command>"` to execute, and
  `herdr pane read <pane-id> --source recent-unwrapped --lines 80`
  to inspect output. Use `herdr --help` and command-group help for
  session selection and pane creation syntax.
