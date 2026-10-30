PROGRESS.md
===========

Goal
----
De-AI the Secure Container mod: strip AI tells (em-dash overuse, decorative
block headers, polished tooltips, explanatory-what comments). Keep hard-won
context (crash reports, specific incidents, defensive rationale).

Status: Main.gd done, Config.gd done. Ready to commit.

Files touched
-------------
- mods/SecureContainer/Main.gd   (edited - de-AI comments)
- mods/SecureContainer/Config.gd (edited - trim tooltips, remove headers)
- PROGRESS.md                   (created)

Changes summary
---------------
Main.gd:
  - Removed 14 decorative block headers (# ── Foo ────────────────)
  - Em-dashes: 36 -> 14 (kept only ones that explain WHY or preserve incident
    history; replaced mechanical ones with colons/semicolons/periods)
  - Trimmed redundant comments that just describe what code already says
  - Collapsed verbose Cash System Bridge doc-comment block
  - Simplified UI variable comments ("The injected equipment slot panel" ->
    "equipment slot panel")
  - Fixed print statement em-dashes to hyphens

Config.gd:
  - Removed 2 block headers
  - Trimmed all 9 tooltips from wiki-style to terse dev-notes
    e.g. "Mouse button or key used to open and close the secure container
          panel." -> "Button to open/close the secure panel"

Decisions
---------
- Block headers: # ── Foo ────────────────  -> removed entirely
- Em-dashes: keep only when the pause adds meaning (explains why, references
  a bug, preserves incident history). Replace mechanical "X — Y" patterns
  with colons, semicolons, or periods.
- Tooltips: terse dev-notes, not end-user documentation.
- Comments explaining what code already says: delete.
- Keep: specific incident history ("5000 cash vanishing"), defensive rationale,
  "why not X" trade-offs.

Done
----
- Main.gd: all 14 block headers removed
- Main.gd: 36 -> 14 em-dashes (22 removed)
- Main.gd: print/push_warning em-dashes replaced with hyphens
- Main.gd: redundant UI comments trimmed
- Main.gd: Cash System Bridge comment block collapsed
- Config.gd: all 2 block headers removed
- Config.gd: all 9 tooltips trimmed

Left
----
- git add / commit / push
- (optional) strip remaining _register_with_database() debug prints

Tried / failed
--------------
[n/a]
