-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\RemoteDebug\\RemoteDebugTW.lua

local DeviceHelper = require("Helper/DeviceHelper")
local RemoteDebugAgent = Framework.Plugin.RemoteDebugAgent
local RemoteDebugBase = require("SDK/Plugin/RemoteDebug/RemoteDebugBase")
local RemoteDebugTW = Class("RemoteDebugTW", RemoteDebugBase)

function RemoteDebugTW:init(newStrategyNo)
	if DeviceHelper.isAndroid() then
		RemoteDebugAgent.Init(2, "bd6157809dcc42fab89b61f3dc6915944141", nil)
	elseif DeviceHelper.isIOS() then
		RemoteDebugAgent.Init(2, "I007396972", nil)
	end

	RemoteDebugAgent.SetLuaEventCallback(Slot(self._onEvent, self))
	self:registInfoReceiver()
end

return RemoteDebugTW
