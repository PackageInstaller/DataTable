-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\RemoteDebug\\RemoteDebugSEA.lua

local DeviceHelper = require("Helper/DeviceHelper")
local RemoteDebugAgent = Framework.Plugin.RemoteDebugAgent
local RemoteDebugBase = require("SDK/Plugin/RemoteDebug/RemoteDebugBase")
local RemoteDebugSEA = Class("RemoteDebugSEA", RemoteDebugBase)

function RemoteDebugSEA:init(newStrategyNo)
	if DeviceHelper.isAndroid() then
		RemoteDebugAgent.Init(2, "b55c37d9668743469dbcdbed8a711acc33e2", nil)
	elseif DeviceHelper.isIOS() then
		RemoteDebugAgent.Init(2, "I007054879", nil)
	end

	RemoteDebugAgent.SetLuaEventCallback(Slot(self._onEvent, self))
	self:registInfoReceiver()
end

return RemoteDebugSEA
