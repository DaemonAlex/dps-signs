# dps-signs

Rotates city messages across every SmartSigns variable-message board (the
freeway matrix signs) on a schedule.

## Status

Not running on DelPerroSands. It needs the paid SmartSigns resource, and SmartSigns is not
installed on the server now. The code is small and complete.

## What it is for

The freeway message boards from SmartSigns stay blank until a police officer or admin types
something into each one. This fills all of them with city messages and keeps changing them, so
the roads feel looked after with no staff work.

## On its own, and with other scripts

**On its own.** Nothing happens. The script waits for SmartSigns to start and has no signs of its
own.

**With a paid sign script (SmartSigns).** Every board shows a three-line message with a matching
icon. Each board shows a different message from its neighbour, so a drive down the freeway reads
as a sequence. Every 12 minutes all boards move to the next message. An officer can still type a
message at a sign. It stays until the next change.

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

## Requirements

- SmartSigns (paid). The folder must be named `SmartSigns`.

## Install

1. Put the folder in your resources and add `ensure dps-signs` after `SmartSigns`.
2. Edit the `DECK` table in `server.lua` to change the messages. Keep every line under 15
   characters.

## Recent changes

- **12 November 2026.** README: status, what it is for, how it works alone and with paid scripts, other DPS scripts.
- **18 August 2026.** First import from the live server. README written. Line endings pinned in `.gitattributes`.

## Author

Made by [DaemonAlex](https://github.com/DaemonAlex) for DelPerroSands.

## Other DPS scripts

All of these are made for DelPerroSands and run together on one Qbox server. Each one works on
its own. The ones marked "pairs with" do more when both are running.

| Script | What it does |
|---|---|
| [dps-inventory](https://github.com/DaemonAlex/dps-inventory) | The inventory: ox_inventory with equipment slots, backpacks, armour plates and a self status panel, in the DelPerroSands colours. |
| [dps-medical](https://github.com/DaemonAlex/dps-medical) | Patient records, illness and diagnostic tests. A companion to wasabi_ambulance. Pairs with dps-inventory: symptoms and diagnoses show on the status panel. |
| [dps-insurance](https://github.com/DaemonAlex/dps-insurance) | Ties m-Insurance into the MDT, impound, hospital and medical chart. Pairs with dps-medical. |
| [dps-studio](https://github.com/DaemonAlex/dps-studio) | Build rooms, doors and portals in game from one panel (`/studio`), with owners and managers so staff do not have to support them. |
| [dps-shops](https://github.com/DaemonAlex/dps-shops) | Shop clerks who greet and react to a robbery, then player-owned shops. |
| [dps-fleet](https://github.com/DaemonAlex/dps-fleet) | Vehicle browser and workshop on one panel: extras, liveries and mods for emergency vehicles. |
| [dps-parking](https://github.com/DaemonAlex/dps-parking) | Parking with valet, impound, violations and reserved spots. |
| [dps-vehiclepersistence](https://github.com/DaemonAlex/dps-vehiclepersistence) | Vehicles stay where they were parked. Pairs with dps-parking. |
| [dps-towjob](https://github.com/DaemonAlex/dps-towjob) | Queue-based tow job with jg-mechanic integration. |
| [dps-services](https://github.com/DaemonAlex/dps-services) | Request a tow and follow it live on the lb-phone and lb-tablet. Pairs with dps-towjob. |
| [dps-autoshops](https://github.com/DaemonAlex/dps-autoshops) | Self-service repair shops when no mechanic is on duty. |
| [dps-cityworker](https://github.com/DaemonAlex/dps-cityworker) | City infrastructure job and career. |
| [dps-ainpcs](https://github.com/DaemonAlex/dps-ainpcs) | NPCs you can talk to, with trust, quests and intel. |
| [dps-badpeds](https://github.com/DaemonAlex/dps-badpeds) | Police interaction with NPCs: stops, arrests, intel and jail records. |
| [dps-gangwars](https://github.com/DaemonAlex/dps-gangwars) | Ambient gang NPCs, territory population and war reinforcements. |
| [dps-rotations](https://github.com/DaemonAlex/dps-rotations) | Moves dealers, harvests and other spots on a fixed schedule. |
| [dps-trains](https://github.com/DaemonAlex/dps-trains) | The train system. Pairs with dps-trains-stock, dps-traintools and dps-transitapp. |
| [dps-transitapp](https://github.com/DaemonAlex/dps-transitapp) | Live train arrival boards on the lb-phone. |
| [dps-faceplant](https://github.com/DaemonAlex/dps-faceplant) | City help, reports and staff tools on the lb-phone and lb-tablet. |
| [dps-chat](https://github.com/DaemonAlex/dps-chat) | A command box for voice-only servers. No chat feed. |
| [dps-filmmode](https://github.com/DaemonAlex/dps-filmmode) | One key hides every HUD layer and gives a smooth free camera for recording. |
