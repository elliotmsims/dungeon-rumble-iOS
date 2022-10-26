# Dungeon Rumble game app (built on iPhone 13 Pro Max simulator)

# Contributions:

William Mannel (20%)
- created Login screen w/ view controller
- created Signup/Change Password screen w/ view controller
- created Leaderboard screen w/ view controller
- created Death screen w/ view controller

Anthony Modica (20%)
- Implemented the audio/music system
- Designed the Settings screen and implemented the Settings view controller 
- Implemented music on/off switch in settings
- Created delete account alert controller (although actual account deletion not yet implemented)

Elliot Sims (30%)
- created Launch screen
- created Authentication Choice screen w/ view controller
- created Play Game screen w/ view controller
- created templates for the screens (custom colors, temporary custom font, border, background color)
- created button/label UI components
- connected all screens with segues
- upgraded game movement/control buttons

Jarad Forristal (30%)
- designed and created game screen / UI and HUD
- created GameWorld object which abstracts the world from the display
- implemented game engine and simple procedural generation and enemy spawning
- integrated the game engine with the GameVC to display in-game content
- implemented character movement, AI interaction, basic score system

# Differences:

* Planned to only create a skeleton game without other screens (Settings, Login, etc), but decided it would help us more to create a full skeleton of the app with all screens.

* Tutorial level was planned but the game does not yet have the content the tutorial is required for (weapons, armor, spells, complex enemies, ...). A basic easy level was implemented instead and this level will be expanded as content is added

* Tutorial level button doesn't do anything currently. Instead, the 'play game' button initially takes the user to the tutorial level. We will map a dedicated tutorial level to the 'Try tutorial' button in the beta release
 
* Music system currently plays a single track on a loop. Starting with beta release, we will have a variety of new tracks, and the current track will change when the user reaches the next level/floor when playing. One of these new tracks will also be a dedicated title-screen/menu track that plays before the user begins the actual game

* Score system was moved to beta release since it requires our firebase backend to be implemented

* The custom font shown in our design document will be on full display across menu screens for beta release, along with other UI-related touch-ups
 
 # Comments
 
 - The Game view was built using iPhone 14 Pro simulator, so it is currently off-centered
