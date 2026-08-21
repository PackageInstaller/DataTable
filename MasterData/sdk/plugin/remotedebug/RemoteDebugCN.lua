-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\RemoteDebug\\RemoteDebugCN.lua

local DeviceHelper = require("Helper/DeviceHelper")
local VersionUtils = require("System/VersionUtils")
local RemoteDebugAgent = Framework.Plugin.RemoteDebugAgent
local RemoteDebugBase = require("SDK/Plugin/RemoteDebug/RemoteDebugBase")
local RemoteDebugCN = Class("RemoteDebugCN", RemoteDebugBase)

function RemoteDebugCN:init(newStrategyNo)
	if VersionUtils.getEngineVersion() < 118667 then
		RemoteDebugAgent.Init(1, nil)
	elseif DeviceHelper.isAndroid() then
		RemoteDebugAgent.Init(1, "57c87c1245fd465dacfa2069be2e72d645c5", nil)
	elseif DeviceHelper.isIOS() then
		RemoteDebugAgent.Init(1, "I008704305", nil)
	end

	RemoteDebugAgent.SetLuaEventCallback(Slot(self._onEvent, self))
	self:registInfoReceiver()
end

return RemoteDebugCN
