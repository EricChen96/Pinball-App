The Godot project is at `/Users/ericchen/Documents/Pinball App`.

## Visual Reference

A **cute retro landscape-adapted pinball** game. Key visual elements:
- Consider object sizes in 16x16 pixels

## Technical specs
- Engine: Godot 4 (GDScript)
- Target: mobile **landscape 16:9 — 1920 × 1080 px**
- Orientation: horizontal (landscape)

** World progression:**
- Each world has # stages and a final boss stage
- Each stage will have a simpler map, unique design, and a mission(s) to complete to finish the stage. Game ends once mission is completed/failed.
- The last stage of each world will be a 'boss' stage
- boss stages will have a map design that is similar to a real life pinball table where it can theoretically go on forever
- After completing a mission chain, a Boss emerges on the table. The table layout shifts to accommodate the encounter. Complete missions to defeat it

**Mission types:**
- Hit a series of targets in order
- Keep the ball in a specific zone for X seconds
- Trigger all bumpers in a lane
- Collect a set of glowing orbs before they disappear
- Defeat all enemies on the table

Completing a full mission chain (typically 5–7 missions) summons a **Boss**.

---

## Designs

Designs impact how the pinball game is played or looks.

| Design | Description |
|---|---|

| Regular | Default gameplay |
| Ball Dash | Ball speed doubles |
| Shadow Match | Game is dark and only the ball is a source of light |

---

### Boss Mechanics
- Boss has a health bar depleted by direct hits
- Boss attacks back: launching obstacles, blocking flipper zones, or temporarily reversing controls
- Special weak points appear periodically — hitting them deals bonus damage
- Boss is defeated when HP reaches zero; rewards a rare powerup and table progression

### Example Bosses

| Boss | Table | Attack Style |
|---|---|---|
| Thornspike | Soul Garden | Launches thorn walls that block ball paths |
| Volt Mech | Neon City | Fires electrical barriers across lanes |
| Wraith King | Hollow Deep | Cloaks himself and switches weak point locations |
| Gale Wing | Sky Drift | Redirects ball with wind blasts |

---

## Progression & Unlocks

- Unlockables include: new ball skins, table themes, skill variations, and soundtrack tracks
- A Soulbook (similar to a Pokedex) tracks all bosses defeated, achievements completed

---

## Economy

- Players earn **Soul Coins** during play, mission completions, and minigames
- Coins are spent at the **Soul Shop** (accessible between balls) for:
  - Temporary powerup boosts
  - Extra ball insurance (one-time save per game)
  - Skill upgrades (increase duration or reduce cooldown)
  - Cosmetics (ball skins, table themes, etc.)

---

## Scoring

- Base points from hitting targets and bumpers
- Mission completion bonuses
- Boss damage bonus
- Minigame performance bonus

---

## Visual & Audio Style

- Stylized, vibrant art with a soul/spirit aesthetic
- Each table has a distinct color palette and ambient soundtrack
- Ball trails and hit effects vary by ball type
- Boss encounters trigger a music shift for dramatic effect

---

*Document version: 0.1 — Initial Game Plan*
*Project: YoYoSoul*

---

## Technical: Screen & Table Dimensions

### Orientation
- **Landscape only** — the player holds their device horizontally (LandscapeLeft / LandscapeRight)
- Target resolution: **1920×1080 (16:9)**; wider devices (20:9, 21:9) show slightly more table width via Unity's Expand mode

### Camera Tracking (TODO)
- A `CameraFollow.cs` script will be added to track the ball on the Y axis, always keeping the ball centered vertically
- Camera X stays fixed (the table fills the full visible width)
- The camera should clamp so it never shows outside the table bounds

## Task list

| # | Task | Status |
|---|---|----|
| 2 | Set up basic pinball table layout | pending |
| 3 | Implement ball physics and launcher | pending |
| 4 | Implement flipper mechanics | pending |
| 5 | Implement ball drain and life system | pending |
| 6 | Build score and UI system | pending |
| 7 | Add bumpers | pending |
| 8 | Camera follow ball vertically | pending |
| 9 | Tune ball physics | pending |
| 10 | Create visual style sprites (cyan walls, beach ball, barrels) | pending |
| 11 | Enemy system — waypoint patrol + die on hit | pending |
| 12 | Level complete flow | pending |
| 13 | Coin/star collectible system | pending |
| 14 | Add sound effects and music | pending |
