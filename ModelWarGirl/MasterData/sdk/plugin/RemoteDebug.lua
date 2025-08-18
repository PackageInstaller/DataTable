-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\RemoteDebug.lua

local RemoteDebugCN = require("SDK/Plugin/RemoteDebug/RemoteDebugCN")
local RemoteDebugTW = require("SDK/Plugin/RemoteDebug/RemoteDebugTW")
local RemoteDebugKR = require("SDK/Plugin/RemoteDebug/RemoteDebugKR")
local RemoteDebugSEA = require("SDK/Plugin/RemoteDebug/RemoteDebugSEA")
local RemoteDebug = {}

function RemoteDebug.setStrategy(newStrategyNo)
	if RegionUtils.isCN() then
		RemoteDebug.remoteImp = RemoteDebugCN()
	elseif RegionUtils.isTW() then
		RemoteDebug.remoteImp = RemoteDebugTW()

		RemoteDebug.remoteImp:setStrategy(0)

		return
	elseif RegionUtils.isKR() then
		RemoteDebug.remoteImp = RemoteDebugKR()
	elseif RegionUtils.isSEA() then
		RemoteDebug.remoteImp = RemoteDebugSEA()
	else
		RemoteDebug.remoteImp = RemoteDebugCN()
	end

	RemoteDebug.remoteImp:setStrategy(newStrategyNo or 0)
end

function RemoteDebug.init(newStrategyNo)
	RemoteDebug.remoteImp:init()
end

function RemoteDebug.setRoleInfo(roleId, roleName, roleAccount, roleServer, gameJson)
	RemoteDebug.remoteImp:setRoleInfo(roleId, roleName, roleAccount, roleServer, gameJson)
end

function RemoteDebug.htpIoctl(requestCmdID, data)
	RemoteDebug.remoteImp:htpIoctl(requestCmdID, data)
end

function RemoteDebug.Imploctl()
	RemoteDebug.remoteImp:Imploctl()
end

function RemoteDebug.EncodeLocal(inputData)
	RemoteDebug.remoteImp:EncodeLocal(inputData)
end

function RemoteDebug.DecodeLocal(inputData)
	RemoteDebug.remoteImp:DecodeLocal(inputData)
end

function RemoteDebug.EncodeLocalByte(inputData)
	RemoteDebug.remoteImp:EncodeLocalByte(inputData)
end

function RemoteDebug.DecodeLocalByte(inputData)
	RemoteDebug.remoteImp:DecodeLocalByte(inputData)
end

function RemoteDebug.registInfoReceiver()
	RemoteDebug.remoteImp:registInfoReceiver()
end

function RemoteDebug.logOut()
	RemoteDebug.remoteImp:logOut()
end

function RemoteDebug.report(userId, userName, userAccount, userServer, reportDesc, verificationSpan, type)
	RemoteDebug.remoteImp:report(userId, userName, userAccount, userServer, reportDesc, verificationSpan, type)
end

function RemoteDebug._onEvent(eventType, arg1, arg2, arg3)
	RemoteDebug.remoteImp:_onEvent(eventType, arg1, arg2, arg3)
end

return RemoteDebug
