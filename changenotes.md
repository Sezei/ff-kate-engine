Change Notes
===

# 08/02/2023
---
Modcharts Added;
- Hotline 024 - Fun Is Infinite (Majin) | BPM fix only
- Hotline 024 - Casette Girl Megamix | BPM fix only
- Vs. Hex - Glitcher | BPM fix only
- Below the Depths - Sink | BPM fix + No-Music sections

Modcharts Changed;
- Seek's Cool Deltarune Mod - HYPERLINK | Edited Score Strings
- Seek's Cool Deltarune Mod - In My Way | Added Note movement + Fixed Clock events

Modcharter Changes;
- Function CameraZoom() now accepts an argument for how strong the zoom should be. (Default is 1)

Engine Changes;
None

# 07/02/2023
---
Modcharts Added;
- Seek's Cool Deltarune Mod - In My Way | Health Changes

Modcharts Changed;
(Only added Method = 'Step' to all current modcharts with lyrics)

Modcharter Changes;
- Added Modchart.Clock() -> Returns a 1/20th of a second clock of after the modchart has started.
- Lyrics now have a Method table which accepts 'Step' or 'Clock' as the arguments.
- Fixed the Note class + Added Note.Fetch() -> Returns the Note Instance (NOT OBJECT) of the note.

Engine Changes;
- You can now change the strings for some of the engine's UI elements.