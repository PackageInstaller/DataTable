-- chunkname: @/tmp/or_script/lua_compile/config.lua

DEBUG = app.isDebug() and 1 or 0
CC_USE_FRAMEWORK = true
CC_DISABLE_GLOBAL = false
CC_DESIGN_RESOLUTION = {
	autoscale = "FIXED_WIDTH",
	height = 640,
	maxfixedx = 2.361111111111111,
	width = 1136,
	callback = function(framesize)
		local ratio = framesize.width / framesize.height

		if ratio >= 1.7777777777777777 then
			return {
				autoscale = "FIXED_HEIGHT"
			}
		end
	end
}
DRAGON_ENABLE_AUTOLOADING = true
DRAGON_AUTOLOADING_CONFIG = "autoloading_config"
GAME_SHOW_FPS = false
GAME_MAX_FPS = 30
GAME_STARTUP_SCENE = "launchScene"
GameConfigs = GameConfigs or {
	battleSceneMode = true
}
