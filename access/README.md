# Eagle/Logi workspace staging preparation

This is **preparation only** for Commonplace G0. Root `index.html`, `js/`, `css/`,
configuration and existing hosting are unchanged. No deployment or database
installation is included. Restoration and live rollout remain deferred.

Logi Assembly edits General_apps parent records referenced by the legacy
`eagle_units` / `eagle_unit_progress` workspace. Its current project/assembly
and node deletion use multiple requests; a later failure can leave earlier
changes committed. This opt-in staging copy calls one atomic server RPC per
operation and obtains editing privileges from verified server membership,
without relying on email or user metadata. Missing authorization fails closed;
old account responses cannot restore editing controls after sign-out/switching.

Run with Node 22 (no dependencies or credentials):

```sh
node --test tests/eagle-access.test.mjs
node access/prepare-staging.mjs --fixture
```

Output: `.staging/eagle-fixture/`. It has a visible fixture banner, a loopback
Supabase URL and an invalid synthetic publishable key. It does not connect to a
hosted backend. No hosted-config flag is provided. The optional Akatsuki broadcast
script is excluded from this isolated copy. Source SHA-256 checks stop preparation
if any reviewed input changes. Linux/Windows CI runs these tests and the builder.

This does not install the SQL, activate Google login on localhost or constitute a
browser/device acceptance result. Real-JWT transaction/concurrency tests live in
Commonplace's disposable Supabase CI. See
[the server readiness contract](https://github.com/Celeritas7/Commonplace/blob/main/platform/acceptance/EAGLE-WORKSPACE-READINESS.md).

Before any real cutover, approve and test revised Commonplace candidates 01/02/07
with the actual deployed client, verified team UUIDs, external readers/jobs,
recovery evidence and saved work. Those SQL candidates are unapplied. Coordinate
the client and guards in a maintenance window; never activate guards while leaving
the old multi-request editor in use. This staging UI permits the server's explicit
Eagle admin/operator writers; all proposed memberships require owner review.
The deployed email-based UI is unchanged by merging this preparation.

The three deletion contracts are `ga_eagle_delete_project`,
`ga_eagle_delete_assembly`, and `ga_eagle_archive_node`, each taking `target_id`.
The role contract is `ga_eagle_workspace_role`, returning the current member role
or null. There is no fallback to direct mutations if an RPC is absent or fails.
Project/assembly removal intentionally deletes their contained units/progress in
one transaction; node archival preserves saved progress. A refused step rolls
back all preceding changes. Retry only after refreshing the actual result.

Broader Logi permissions, other editing workflows, the separate role table and
any distinct Eagle Advanced deployment remain separate G0 review items. This is
not a claim that the whole shared project is safe for new Commonplace users.
