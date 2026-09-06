-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/netconn/NetConnMgrExt.lua

module("logiccommon.common.netconn.NetConnMgrExt", package.seeall)

local NetConnMgrExt = {}
local forceSendMsg = NetConnMgr.forceSendMsg
local handleMsg = NetConnMgr._handleMsg
local sendMsg = NetConnMgr.sendMsg
local sendSysMsg = NetConnMgr.sendSysMsg
local sendEmptyMsg = NetConnMgr.sendEmptyMsg

function NetConnMgr:disbale()
	self._disable = true
end

function NetConnMgr:enabled()
	self._disable = nil
end

function NetConnMgr:isConnected(connType)
	return self._socketMgr:IsConnected(connType) or self._socketMgr:IsConnecting(connType)
end

function NetConnMgr:_handleMsg(status, extId, cmd, data, downTag, connType)
	return handleMsg(self, status, extId, cmd, data, downTag, connType)
end

function NetConnMgr:sendMsg(msg, connType)
	if self._disable then
		return
	end

	return sendMsg(self, msg, connType)
end

function NetConnMgr:sendSysMsg(cmdId, msg, connType)
	if self._disable then
		return
	end

	return sendSysMsg(self, cmdId, msg, connType)
end

function NetConnMgr:sendEmptyMsg(extId, cmd, connType)
	if self._disable then
		return
	end

	return sendEmptyMsg(self, extId, cmd, connType)
end

function NetConnMgr:forceSendMsg(extId, cmd, data, connType)
	if self._disable then
		return
	end

	return forceSendMsg(self, extId, cmd, data, connType)
end

local Time = UnityEngine.Time
local lastHeartBeatTime = 0
local lastTipsTime = 0
local warningTime = 20
local tipsTime = 5
local isInGame

function NetConnMgrExt.init()
	lastHeartBeatTime = 0
	lastTipsTime = 0
	warningTime = 20
	tipsTime = 5
	isInGame = nil
end

function NetConnMgrExt.setInGame()
	isInGame = true
end

function NetConnMgrExt.markHeartBeatRequested()
	lastHeartBeatTime = Time.realtimeSinceStartup
	lastTipsTime = 0
end

function NetConnMgrExt.markHeartBeatRespont()
	lastHeartBeatTime = 0
	lastTipsTime = 0
end

function NetConnMgrExt.checkNetword()
	if isInGame and lastHeartBeatTime > 0 then
		local realtimeSinceStartup = Time.realtimeSinceStartup
		local timeDelta = realtimeSinceStartup - lastHeartBeatTime

		if timeDelta >= warningTime and (lastTipsTime == 0 or realtimeSinceStartup - lastTipsTime >= tipsTime) then
			lastTipsTime = realtimeSinceStartup

			FloatWordMgr.instance:show(lang("网络不佳，如果游戏不能正常运行，请检查网络正常后退出游戏重新打开。"))
		end
	end
end

return NetConnMgrExt
