# Contributing to Mas4trt/protos

This repo is the single source of truth for `auth.v1`, consumed by every
service that talks to `sso` (currently: `sso` itself server-side, `sso-web`
client-side via grpc-web). Treat schema changes with the same care as a
public API, because that's what this is.

## Golden rule

**Never edit an already-released message or RPC in a breaking way.**
`buf breaking` runs in CI against `origin/main` and will fail the PR if you
do — that's not a false positive to work around, it's the whole point of
this repo.

Breaking = renaming/removing a field or RPC, changing a field's number or
type, renaming a message. Non-breaking = adding a new optional field
(next unused number), adding a new RPC, adding a new message, adding an
enum value.

If you need an incompatible change, it's a new package version
(`auth.v2`), not a modification of `auth.v1` — see the README's
[Versioning](README.md#versioning) section.

## Making a change

1. Edit `proto/auth/v1/auth.proto`.
2. `buf lint` locally (`buf lint`) — matches what CI runs.
3. `buf breaking --against '.git#ref=origin/main'` locally before pushing.
4. `make proto` to regenerate `gen/go/...`.
5. Commit the `.proto` change **and** the regenerated code in the same PR.
   Never hand-edit files under `gen/` — they're marked
   `DO NOT EDIT` for a reason and will be overwritten.
6. Tag a release (`vX.Y.Z`) once merged — consumers pin to tags, not
   `main` (see `make proto-update` in the `sso` repo).

## Review expectations

Because every consumer trusts this repo, PRs here get held to a higher bar
than a typical app-repo PR:

- Field additions should include a one-line comment on intended semantics
  if the name alone is ambiguous.
- Removing/deprecating a field needs a note on what consumers should
  migrate to and by when.
- New RPCs should have their status-code contract documented in the
  consuming service's docs (e.g. `sso`'s `docs/Connecting.md`), not left
  implicit.
