-- chunkname: @IQIGame\\Main.lua

require("IQIGame.RequireLua")

function _G_ERROR_BACK(msg)
	logError(msg)
end

function Main()
	ResourceS.ResourceBlackboard.UnloadABSwitch_NEW = false
	ResourceS.ResourceBlackboard.UnloadABByUnityDep = true

	Initialization.Init()
end

function OnApplicationPause(isPause)
	Initialization.OnApplicationPause(isPause)
end

function OnApplicationFocus(isActive)
	Initialization.OnApplicationFocus(isActive)
end

xpcall(Main, _G_ERROR_BACK)
