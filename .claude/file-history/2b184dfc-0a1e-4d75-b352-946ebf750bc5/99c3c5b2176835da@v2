---
name: HA API Token
description: Long-lived access token for Home Assistant REST API at 192.168.68.79:8123
type: reference
---

Token named "Claude", created 2026-03-26. Used to push Lovelace config and reload dashboards without browser interaction.

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiI2N2JiYmVlOTNkMTE0MjlmOThkYWJjOTE0MjYwZjI4MSIsImlhdCI6MTc3NDU1ODEwMiwiZXhwIjoyMDg5OTE4MTAyfQ.JvV_Rem2SK1K8-Dj-3Hys9Bsd9B25JSziX1SAV7I_WE
```

**Push Lovelace config** (replaces file + updates HA memory immediately):
```bash
curl -s -X POST http://192.168.68.79:8123/api/lovelace/config \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d @- < /path/to/config.json
```

**Reload resources only:**
```bash
curl -s -X POST http://192.168.68.79:8123/api/services/lovelace/reload_resources \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" -d '{}'
```
