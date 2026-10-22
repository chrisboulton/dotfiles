* When starting a web interface for me to open or review—such as a
  dev server, preview, generated report, or dashboard—make it
  accessible across my computers and phone. Bind it to a LAN
  interface or `0.0.0.0`, and share a full URL using
  `<hostname>.100vn.chrisboulton.net:<port>` with the hosting
  computer's hostname. Verify that URL responds before sharing it.

  For backend services, workers, and internal listeners, preserve
  their normal network settings unless the task requires a change.

* On `cb-mbp`, perform SSH work through a local Rex pane when it
  involves multiple commands, ongoing processes, or a session I
  may want to inspect. Direct SSH is fine for quick one-off checks.

  Follow the rex skill. Using Rex outside a managed pane is allowed,
  even with `REX_SESSION` and `REX_BLOCK` unset.

  Use explicit session and block (pane) IDs. Reuse a suitable session
  or create a dedicated one. Preserve my focus and report the IDs
  of anything left open.

  Commands:
  - Discover: `rex ls --json`
  - List panes: `rex block ls -s SESSION --json`
  - New SSH session:
    `rex new TASK-NAME --window HOST --keep-open --json -- ssh -tt HOST`
    This does not switch the app to the new session.
  - New SSH tab in an existing session:
    `rex run -s SESSION --label HOST --focus=false --keep-open --json -- ssh -tt HOST`
  - Read the current screen:
    `rex capture -s SESSION -b BLOCK --trim --unwrap`
  - After confirming a shell prompt, enter a command:
    `rex send -s SESSION -b BLOCK 'COMMAND'`
    then `rex send-key -s SESSION -b BLOCK enter`.

  Clean up panes and sessions you created when finished. Retain
  anything still needed for a running process or my inspection,
  and explain why. Preserve pre-existing work. Exit SSH before
  closing its pane with `rex block close -s SESSION BLOCK`; remove
  a dedicated session with `rex kill SESSION` once all its contents
  can be closed.
