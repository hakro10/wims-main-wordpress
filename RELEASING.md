# Releasing

Use the versioning rules in `agents.md`:

- Bug fix: bump by +0.0.1 (patch)
- New feature: bump by +0.1.0 (minor)

## Quick bump

```
# Patch release (bug fix)
scripts/bump-version.sh --type patch

# Minor release (new feature)
scripts/bump-version.sh --type minor

# Or set an explicit version
scripts/bump-version.sh --to 1.2.3
```

This updates and commits in the submodule `app/public` and then updates the superproject pointer:

- Plugin: `wp-content/plugins/warehouse-inventory-manager/warehouse-inventory-manager.php`
  - Header `Version: x.y.z`
  - `define('WH_INVENTORY_VERSION','x.y.z')`
- Theme: `wp-content/themes/warehouse-inventory/style.css`
  - Header `Version: x.y.z`

## Changelog

After bumping, add a short entry to the changelog in `agents.md` under “Changelog (engineering updates)” with the date and a concise summary of changes.

## Verify

- Clear caches and reload the app.
- Check plugin list (WordPress admin) and theme style header for the updated version.
- Verify asset cache-busting (enqueue versions use `WH_INVENTORY_VERSION`).

