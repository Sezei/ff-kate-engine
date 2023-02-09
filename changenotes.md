Change Notes
===

# 09/02/2023
---
Modcharts Added;
None

Modcharts Changed;
None

Modcharter Changes;
- Remade the NoteHit and NoteMiss events to have the framework as the first argument.
- Modcharts now have Name and Author properties, which can be used to display the name and author of the modchart in the Debug section.
- You can now create shitpost charts with Modchart.ShitpostChart = true; They can be disabled in the Modcharting tab in the UI as well if unwanted.

Engine Changes;
- Added a setting to change the debug visibility in the Main tab.
- Slider/Booleans now fire the callback upon initiating the engine.

# 08/02/2023
---
Modcharts Added;
- Hotline 024 - Fun Is Infinite (Majin) | BPM fix only
- Hotline 024 - Casette Girl Megamix | BPM fix only
- Vs. Hex - Glitcher | BPM fix only
- Below the Depths - Sink | BPM fix + No-Music sections
- D-Sides - Ridge | BPM fix only

Modcharts Changed;
- Seek's Cool Deltarune Mod - HYPERLINK | Edited Score Strings
- Seek's Cool Deltarune Mod - In My Way | Added Note movement + Fixed Clock events

Modcharter Changes;
- Function CameraZoom() now accepts an argument for how strong the zoom should be. (Default is 1, if not changed in settings)

Engine Changes;
- Added a new tab in the UI for modcharts, which decide on how modcharts could be played.
- Added settings for the custom Perfect rating, which can manipulate how the perfect rating is calculated and/or even enabled. 

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