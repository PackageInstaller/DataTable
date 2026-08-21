-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\RemoteDebug\\RemoteDebugKR.lua

local DeviceHelper = require("Helper/DeviceHelper")
local RemoteDebugAgent = Framework.Plugin.RemoteDebugAgent
local RemoteDebugBase = require("SDK/Plugin/RemoteDebug/RemoteDebugBase")
local RemoteDebugKR = Class("RemoteDebugKR", RemoteDebugBase)

function RemoteDebugKR:init(newStrategyNo)
	if DeviceHelper.isAndroid() then
		RemoteDebugAgent.Init(3, "be5a1d68225a404ca3a0d946b9b85eb35e80", nil)
	elseif DeviceHelper.isIOS() then
		RemoteDebugAgent.Init(3, "I004072250", nil)
	end

	RemoteDebugAgent.SetLuaEventCallback(Slot(self._onEvent, self))
	self:registInfoReceiver()
end

return RemoteDebugKR
