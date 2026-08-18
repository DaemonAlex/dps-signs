# dps-signs

Rotates city messages across every SmartSigns variable-message board (the
freeway matrix signs) on a schedule.

## Behavior
- 12-message deck, city-flavored (safety PSAs, transit notices, DPS flavor),
  each with a matching matrix icon (drink-drive, no-phone, roadwork, ...).
- All 76 boards are covered; **each sign shows a different message**, offset
  by sign id, so driving a route reads as a sequence. The whole deck shifts
  every 12 minutes.
- Police/admin manual edits at a sign keypad still work; the next rotation
  pass reclaims the board (~12 min manual lifetime).

## Editing messages
The `DECK` table at the top of `server.lua`. Hard rule from SmartSigns:
**every line must be under 15 characters** or the update is rejected.

Depends on the SmartSigns resource (uses its `SmartSigns:apiUpdateSign`
server event, which bypasses player permission checks for server calls).
