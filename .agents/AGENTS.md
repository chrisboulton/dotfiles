* For URLs to services running on my computers, use
  `http[s]://<hostname>.100vn.chrisboulton.net:<port>` with the hosting
  computer's hostname, never localhost or a loopback address. Bind the
  service to a LAN interface or `0.0.0.0` and verify the URL responds
  before sharing it. I access these services across computers and
  my phone.

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
