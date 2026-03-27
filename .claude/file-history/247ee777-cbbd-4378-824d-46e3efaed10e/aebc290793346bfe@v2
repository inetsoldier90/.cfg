# Plan: Dashboard Redesign

## Context
Full rewrite of the Lovelace dashboard. User wants a modern dark-themed dashboard that works on desktop and mobile, with side-by-side layout: garage door on the left, room lights on the right. Room groups with drill-down to individual light control. HACS cards to be installed as needed.

## HACS Add-ons to Install First

1. **Mushroom Cards** (`lovelace-mushroom`) — needed for chips row + cover card
   - Install via HACS → Frontend → search "Mushroom"
   - After install, add the resource in HACS or manually

2. **Mushroom Themes** (optional but recommended) — provides dark/light theme variants that match Mushroom cards
   - Install via HACS → Themes → search "Mushroom Themes"

These are in addition to what's already installed: `hue-like-light-card` and `hass-hue-icons`.

## Dashboard Design

### File to modify
`/home/inet/dev/ha/config/.storage/lovelace`

### Layout (Sections, max_columns: 3)

```
[─────────── Full width: mushroom-chips-card ───────────]
  chip: lights on count    chip: garage door state

[── col 1 (garage) ──────][── col 2-3 (lights) ─────────]
  mushroom-cover-card         hue-like-light-card
  cover.garage_door             Basement
  • Open / Close / Stop          • light.dining
  • State badge                  • light.kitchen
                                 • light.living
                                 • light.entrance
                               hue-like-light-card
                                 Bedroom
                                 • light.bedroom
                                 • light.wake_up_light
                               hue-like-light-card
                                 Individual Bulbs
                                 • light.signe_gradient_floor_1
                                 • light.hue_filament_bulb_1
                                 • light.hue_filament_bulb_2
                                 • light.hue_pillar_spot_2 (+ others)
```

On mobile: columns auto-stack to single column. Chips → Garage → Lights.

### Individual light control
`hue-like-light-card` lists individual entity IDs inside each room card. Tapping an individual light opens its more-info popup (brightness slider, color temp, color picker for color bulbs). This fulfills "click one to adjust on its own."

### Network view
Kept unchanged.

### Theme
Use HA's built-in dark mode (profile → Theme → Dark). Optionally install Mushroom Themes from HACS for better Mushroom card theming.

## Implementation Steps

1. Confirm user has installed Mushroom Cards via HACS (required before dashboard loads correctly)
2. Write new JSON to `.storage/lovelace` with the sections layout
3. Reload HA dashboard (via UI or `ha lovelace reload` over SSH)

## Verification
- SSH to 192.168.68.79 and check HA is running: `ha core info`
- Open dashboard on both desktop browser and mobile to confirm responsive layout
- Test garage open/close buttons trigger correct scripts
- Test individual light tap opens more-info with sliders
