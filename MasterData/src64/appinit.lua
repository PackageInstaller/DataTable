SIZE_X = 640
SIZE_Y = 1136

math.randomseed(tonumber(tostring(math.sin(os.time())):sub(4, 12)))

local var_0_0 = cc.Director:getInstance()

require("config")
require("json")

local var_0_1 = (function(arg_1_0)
	local var_1_0, var_1_1, var_1_2, var_1_3 = arg_1_0:match("(%d+).(%d+).(%d+).(%d+)")

	if GAME_STORAGE_FOLDER then
		return string.format("%s/v%s%s", GAME_STORAGE_FOLDER, var_1_0, var_1_1)
	else
		return string.format("v%s%s", var_1_0, var_1_1)
	end
end)(config.version)

if cc.Native.useAntiHexieResource and cc.Native:useAntiHexieResource() then
	cc.UserDefault:getInstance():setBoolForKey("antihexie", true)
end

if cc.UserDefault:getInstance():getBoolForKey("antihexie", false) then
	if cc.Application:getInstance():getTargetPlatform() == cc.PLATFORM_OS_WINDOWS then
		cc.FileUtils:getInstance():addSearchPath("origin")
		cc.FileUtils:getInstance():addSearchPath("origin/roleimage")
	end

	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/origin")
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/origin/roleimage")
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/antihexie")
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/antihexie/roleimage")
end

cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1)
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/res")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/res/sound")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/res/roleimage")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/res/effect")

if config._DEBUG then
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/res/CocosRes_source")
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/res/CocosRes_source/fonts")
else
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/res/ui")
	cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/res/ui/fonts")
end

cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_1 .. "/res/CityMap")

local var_0_2 = string.format("%s/bugfix", GAME_STORAGE_FOLDER)

cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_2)
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_2 .. "/res")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_2 .. "/res/sound")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_2 .. "/res/roleimage")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_2 .. "/res/effect")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_2 .. "/res/ui")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_2 .. "/res/ui/fonts")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/" .. var_0_2 .. "/res/CityMap")
cc.FileUtils:getInstance():addSearchPath("res")
cc.FileUtils:getInstance():addSearchPath("res/sound")
cc.FileUtils:getInstance():addSearchPath("res/roleimage")
cc.FileUtils:getInstance():addSearchPath("res/effect")

if config._DEBUG then
	cc.FileUtils:getInstance():addSearchPath("res/CocosRes_source")
	cc.FileUtils:getInstance():addSearchPath("res/CocosRes_source/fonts")
else
	cc.FileUtils:getInstance():addSearchPath("res/ui")
	cc.FileUtils:getInstance():addSearchPath("res/ui/fonts")
end

cc.FileUtils:getInstance():addSearchPath("res/CityMap")
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath())
cc.FileUtils:getInstance():addSearchPath(cc.FileUtils:getInstance():getWritablePath() .. "/res")

GameDisplay = require("display")

var_0_0:setAnimationInterval(0.016666666666666666)
var_0_0:setProjection(cc.DIRECTOR_PROJECTION2_D)
Rapid2D_CAudio.checkInit()
cc.SpriteFrameCache:getInstance():addSpriteFrames("defaulterrorimg.plist")

DeviceManager = require("controller.device_manager")

if DeviceManager.platform == "ios" or DeviceManager.platform == "android" then
	require("controller.application_manager")

	PushManager = require("controller.umPushForLua")

	if config._DISABLE_GAMELOG then
		function __G__GAMELOG__(...)
			return
		end
	end
end

TrackingManager = require("controller.tracking_luabinding")

local var_0_3 = DeviceManager.getPackageChannel()

if var_0_3 == "FY" then
	if config.packagechannel == "feiyu" then
		FeiyuManager = require("controller.feiyu_sdk_bridge")
	end
else
	SDKManager = require((string.format("controller.sdk_bridge.%s_sdk_bridge", var_0_3)))
end

local var_0_4 = print

function _G.print(...)
	if config._PRINT then
		var_0_4("l2log:: ", ...)
	else
		return
	end
end

cc.Director:getInstance():getTextureCache():addFilePathToRemoveList("role/")
cc.Director:getInstance():getTextureCache():addFilePathToRemoveList("role1/")
cc.Director:getInstance():getTextureCache():addFilePathToRemoveList("mainScenebg/")
cc.Director:getInstance():getTextureCache():addFilePathToRemoveList("equipment/")
cc.Director:getInstance():getTextureCache():addFilePathToRemoveList("CityMap/")
cc.Director:getInstance():getTextureCache():addFilePathToRemoveList("CaptureScreen/")
cc.Director:getInstance():getTextureCache():addFilePathToRemoveList("expression/")

if DeviceManager.platform == "windows" and config._DEBUG_RUNCONSOLE then
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(function()
		require("devtools.debug_console"):runConsloe()
	end, 0, false)
end

return {
	runApp = function()
		if config._MEM then
			var_0_0:getScheduler():scheduleScriptFunc(function()
				print("---------------------------------------------------")
				print(string.format("LUA VM MEMORY USED: %0.2f KB", collectgarbage("count")))
				print("---------------------------------------------------")
			end, config._MEM_INTERVAL or 10, false)
		end

		if DeviceManager.platform == "ios" then
			require("view.Scene.AssetsScene")

			if cc.Director:getInstance():getRunningScene() then
				cc.Director:getInstance():replaceScene(AssetsScene:createScene())
			else
				cc.Director:getInstance():runWithScene(AssetsScene:createScene())
			end
		elseif DeviceManager.platform == "windows" then
			if config._DEVELOP_MODE then
				require("devtools.appinit")
			else
				require("view.Scene.FlashScene")

				if cc.Director:getInstance():getRunningScene() then
					print("Replace To FlashScene!!!!!")
					cc.Director:getInstance():replaceScene(FlashScene:createScene())
				else
					cc.Director:getInstance():runWithScene(FlashScene:createScene())
				end
			end
		else
			require("view.Scene.FlashScene")

			if cc.Director:getInstance():getRunningScene() then
				cc.Director:getInstance():replaceScene(FlashScene:createScene())
			else
				cc.Director:getInstance():runWithScene(FlashScene:createScene())
			end
		end
	end
}
