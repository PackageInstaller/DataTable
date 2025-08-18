-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\RemoteDebug\\RemoteDebugBase.lua

local NetService = require("Network/NetService")
local RemoteDebugAgent = Framework.Plugin.RemoteDebugAgent
local RemoteDebugBase = Class("RemoteDebugBase")
local EventType = {
	kDropBeatAndroid = 1,
	kDropBeatIOS = 2
}

function RemoteDebugBase:setStrategy(newStrategyNo)
	RemoteDebugAgent.SetStrategy(newStrategyNo or 0)
end

function RemoteDebugBase:init(newStrategyNo)
	RemoteDebugAgent.Init(1, nil)
	RemoteDebugAgent.SetLuaEventCallback(Slot(self._onEvent, self))
	self:registInfoReceiver()
end

function RemoteDebugBase:setRoleInfo(roleId, roleName, roleAccount, roleServer, gameJson)
	RemoteDebugAgent.SetRoleInfo(roleId, roleName, roleAccount, roleServer, gameJson)
end

function RemoteDebugBase:htpIoctl(requestCmdID, data)
	local receiveMsg = RemoteDebugAgent.intHtpIoctl(requestCmdID, "")

	return receiveMsg
end

function RemoteDebugBase:Imploctl()
	RemoteDebugAgent.Imploctl()
end

function RemoteDebugBase:EncodeLocal(inputData)
	return RemoteDebugAgent.EncodeLocal(inputData)
end

function RemoteDebugBase:DecodeLocal(inputData)
	return RemoteDebugAgent.DecodeLocal(inputData)
end

function RemoteDebugBase:EncodeLocalByte(inputData)
	return RemoteDebugAgent.EncodeLocalByte(inputData)
end

function RemoteDebugBase:DecodeLocalByte(inputData)
	return RemoteDebugAgent.DecodeLocalByte(inputData)
end

function RemoteDebugBase:registInfoReceiver()
	RemoteDebugAgent.registInfoReceiver()
end

function RemoteDebugBase:logOut()
	RemoteDebugAgent.LoginOut()
end

function RemoteDebugBase:report(userId, userName, userAccount, userServer, reportDesc, verificationSpan, type)
	RemoteDebugAgent.Report(userId, userName, userAccount, userServer, reportDesc, verificationSpan, type)
end

function RemoteDebugBase:_onEvent(eventType, arg1, arg2, arg3)
	if eventType == EventType.kDropBeatAndroid or eventType == EventType.kDropBeatIOS then
		NetService.setHeartBeatData(arg1)
	end
end

return RemoteDebugBase
