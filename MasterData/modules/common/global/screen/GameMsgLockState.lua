-- chunkname: @modules/common/global/screen/GameMsgLockState.lua

module("modules.common.global.screen.GameMsgLockState", package.seeall)

local GameMsgLockState = class("GameMsgLockState")

GameMsgLockState.IgnoreCmds = {
	[24032] = true,
	[-31567] = true
}
GameMsgLockState.IgnoreExceptionCmd = {
	25708
}
GameMsgLockState.IgnoreExceptionStatus = {
	-274,
	-275,
	-276,
	-277,
	-278,
	-123,
	-124,
	-15,
	-13,
	-26,
	-310,
	-311,
	-312,
	-314,
	-321,
	-402,
	-403,
	-581,
	-582,
	-583,
	-584,
	-585,
	-586,
	-587
}

function GameMsgLockState:ctor()
	self._sendCmdList = {}
	self._sendProtoList = {}
	self._ignoreExceptionCmd = {}
	self._ignoreExceptionStatus = {}
	self._blockCmdDict = {}
	self._blockCount = 0

	self:addConstEvents()
end

function GameMsgLockState:addConstEvents()
	LuaSocketMgr.instance:registerPreSender(self)
	LuaSocketMgr.instance:registerPreReceiver(self)
	self:setIgnoreException(GameMsgLockState.IgnoreExceptionCmd, GameMsgLockState.IgnoreExceptionStatus)
	LoginController.instance:registerCallback(LoginEvent.OnLogout, self._endBlock, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, self._endBlock, self)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnMsgTimeout, self._endBlock, self)
end

function GameMsgLockState:preSendProto(cmd, proto, socketId)
	if GameMsgLockState.IgnoreCmds[cmd] then
		return
	end

	if self._blockCount == 0 then
		UIBlockMgr.instance:startBlock(UIBlockKey.MsgLock)
	end

	if self._blockCmdDict[cmd] then
		self._blockCmdDict[cmd] = self._blockCmdDict[cmd] + 1 or 1
	end

	self._blockCount = self._blockCount + 1

	TaskDispatcher.cancelTask(self._onDelayCancelLock, self)
	TaskDispatcher.runDelay(self._onDelayCancelLock, self, 30)
	table.insert(self._sendCmdList, cmd)
	table.insert(self._sendProtoList, proto)
end

function GameMsgLockState:preReceiveMsg(resultCode, cmd, responseName, msg, downTag, socketId)
	if GameMsgLockState.IgnoreCmds[cmd] then
		return
	end

	local preSendProto

	while #self._sendCmdList > 0 do
		local preSendCmd = table.remove(self._sendCmdList, #self._sendCmdList)
		local proto = table.remove(self._sendProtoList, #self._sendProtoList)

		if preSendCmd == cmd then
			preSendProto = proto

			break
		end
	end

	if resultCode ~= 0 and self:_canLogException(cmd, resultCode) then
		local toastCO = lua_toast.configDict[resultCode]

		if toastCO then
			if not toastCO.tips then
				local resultDesc = ""
				local sendParam = preSendProto and tostring(preSendProto) or ""

				logError(string.format("<== Recv Msg, cmd:%d %s resultCode:%d desc:%s param:%s", cmd, responseName, resultCode, resultDesc, sendParam))
			end
		end
	end

	local hasSendCmdCount = self._blockCmdDict[cmd]

	if hasSendCmdCount and hasSendCmdCount > 0 then
		if hasSendCmdCount == 1 then
			self._blockCmdDict[cmd] = nil
		else
			self._blockCmdDict[cmd] = hasSendCmdCount - 1
		end

		self._blockCount = self._blockCount - 1

		if self._blockCount == 0 then
			UIBlockMgr.instance:endBlock(UIBlockKey.MsgLock)
			TaskDispatcher.cancelTask(self._onDelayCancelLock, self)
		end
	end
end

function GameMsgLockState:_onDelayCancelLock()
	local temp = {}

	for cmd, _ in pairs(self._blockCmdDict) do
		table.insert(temp, module_cmd[cmd][2])
	end

	self:_endBlock()

	if isDebugBuild then
		logError("msg lock: " .. table.concat(temp, " "))
	end
end

function GameMsgLockState:_endBlock()
	TaskDispatcher.cancelTask(self._onDelayCancelLock, self)
	UIBlockMgr.instance:endBlock(UIBlockKey.MsgLock)

	self._sendCmdList = {}
	self._sendProtoList = {}
	self._blockCmdDict = {}
	self._blockCount = 0
end

function GameMsgLockState:setIgnoreException(ignoreCmdList, ignoreStatusList)
	if ignoreCmdList then
		for _, cmd in ipairs(ignoreCmdList) do
			self._ignoreExceptionCmd[cmd] = true
		end
	end

	if ignoreStatusList then
		for _, status in ipairs(ignoreStatusList) do
			self._ignoreExceptionStatus[status] = true
		end
	end
end

function GameMsgLockState:_canLogException(cmd, status)
	return not self._ignoreExceptionCmd[cmd] and not self._ignoreExceptionStatus[status]
end

return GameMsgLockState
