-- chunkname: @IQIGame\\Main.lua

require("IQIGame.RequireLua")

function _G_ERROR_BACK(msg)
	logError(msg)
end

function Main()
	ResourceS.ResourceBlackboard.UnloadABSwitch = false

	Initialization.Init()
end

xpcall(Main, _G_ERROR_BACK)
