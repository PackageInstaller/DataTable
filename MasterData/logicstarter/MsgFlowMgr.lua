-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicstarter/starter/reconnection/MsgFlowMgr.lua

module(..., package.seeall)

local MsgFlowMgr = class("MsgFlowMgr")

function MsgFlowMgr:ctor()
	self._curDownTag = -1
	self._gettingLostMsg = false
	self._lostMsgCounter = 0
	self._setting = nil
	self._isConnected = false
	self._reconnecting = false
	self._blockedMap = {}
	self._blockingNum = 0
	self._sendingQueque = MsgQueue.New()
	self._lastSendExtId = false
	self._lastSendCmd = false
	self._lastSendTime = false
	self._sendTimeOut = 5
	self._checkSendInterval = 2.3
	self._ignoreAutoShowFloatMsgList = {}
	self._forcePrintCmd = {}
	self._canForcePrintCmd = false
end

function MsgFlowMgr:init()
	self._resultCode = usingnow("logicconfig.config.t_lang_tip_result_code")
	self._settingProto = usingnow("logic.setting.setting_proto")

	NetConnMgr.instance:setMsgSendFilter(self._msgSendFilter, self)
	NetConnMgr.instance:setMsgReceiveFilter(self._handleMsg, self)
end

function MsgFlowMgr:isBlocked(structName)
	local extId, cmd = NetConnMgr.instance:getCmdInfo2(structName)

	if extId then
		local blockCmds = self._blockedMap[extId]

		if blockCmds and blockCmds[cmd] then
			return true
		end
	end

	return false
end

function MsgFlowMgr:getResultCodeStr(status)
	local statusKey = "rc_" .. status
	local statusStr = self._resultCode[statusKey]

	if statusStr then
		local langKey = "content" .. LanguageMgr.instance:getLanguageType()

		return statusStr[langKey]
	end
end

function MsgFlowMgr:_msgSendFilter(extId, cmd, data, connType)
	local cmds = self._settingProto[extId]
	local cmdCfg

	if cmds then
		cmdCfg = cmds[cmd]
	end

	if cmdCfg and cmdCfg.block then
		local blockCmds = self._blockedMap[extId]

		if blockCmds then
			if blockCmds[cmd] then
				printInfo(LogTag.NETWORK, "MsgFlowMgr:_msgSendFilter() blocked one message! extId&cmd=", extId, cmd)

				return false
			end
		else
			blockCmds = {}
			self._blockedMap[extId] = blockCmds
		end

		blockCmds[cmd] = true
		self._blockingNum = self._blockingNum + 1

		if self._canForcePrintCmd then
			self._forcePrintCmd[extId] = self._forcePrintCmd[extId] or {}
			self._forcePrintCmd[extId][cmd] = true

			forcePrint("forcePrintCmd Send extId:", extId, "cmd:", cmd)
		end

		WaitingView.instance:show("tip_waiting_requesting", WaitingView.Flag_BlockMsg)
	end

	local isSysCmd = extId == -1
	local isPushCmd = cmdCfg and #cmdCfg == 1
	local isNoReply = cmdCfg and #cmdCfg == 1
	local isMoveCmd = extId == 4 and cmd == 9
	local isBeatCmd = extId == 1 and cmd == 1
	local isSurveyCmd = extId == 29 and cmd == 1

	if not isSysCmd and not isPushCmd and not isMoveCmd and not isBeatCmd and not isSurveyCmd then
		if enableDebug then
			printInfo(LogTag.NETWORK, "add send msg to sendingQueue, extId=" .. extId .. ",cmd=" .. cmd)
		end

		self._sendingQueque:enqueue(extId, cmd, data)
	end

	if not self._isConnected then
		if enableDebug then
			printInfo(LogTag.NETWORK, "当前网络没有连接上，不进行发送")
		end

		return false
	elseif self._reconnecting and not isSysCmd then
		if enableDebug then
			printInfo(LogTag.NETWORK, "重连中，不进行发送")
		end

		return false
	end

	if not isNoReply then
		self._lastSendExtId = extId
		self._lastSendCmd = cmd
		self._lastSendTime = os.time()
	end

	return true
end

function MsgFlowMgr:_handleMsg(extId, cmd, status, structName, msg, downTag, connType)
	if enableDebug and not NetConnMgr.instance:isIgnored(extId, cmd) then
		printInfo(LogTag.NETWORK, string.format("MsgFlowMgr_handleMsg,extId=%s,cmd=%s,status=%s,structName=%s", extId, cmd, status, structName))
	end

	if self._forcePrintCmd[extId] and self._forcePrintCmd[extId][cmd] then
		self._forcePrintCmd[extId][cmd] = nil

		forcePrint("forcePrintCmd Recieve extId:", extId, "cmd:", cmd)
	end

	if downTag >= 0 and downTag <= 127 then
		self._curDownTag = downTag
	end

	if status >= 0 or extId <= 0 or extId == 26 and cmd == 11 or extId == 26 and cmd == 2 or extId == 26 and cmd == 2 then
		-- block empty
	elseif not self:_getIgnoreAutoShowFloatMsg(extId, cmd) then
		local statusKey = "rc_" .. status

		if statusKey == "rc_-51" then
			ViewMgr.instance:open(ViewName.RecoveryTili)
		elseif statusKey == "rc_-106" or statusKey == "rc_-5207" then
			-- block empty
		elseif statusKey == "rc_-6101" then
			-- block empty
		elseif statusKey == "rc_-2634" or statusKey == "rc_-2633" then
			-- block empty
		elseif not self._customHandledErrCodes or not self._customHandledErrCodes[statusKey] then
			local statusStr = self._resultCode[statusKey]

			if statusStr then
				local langKey = "content" .. LanguageMgr.instance:getLanguageType()
				local msg = statusStr[langKey]

				if enableDebug then
					msg = msg .. "[" .. status .. "]"
				end

				FloatWordMgr.instance:show(msg)
				printWarn(msg)
			else
				printInfo(LogTag.NETWORK, "no message for result code:", status)
			end
		end
	end

	local blockCmds = self._blockedMap[extId]

	if blockCmds and blockCmds[cmd] then
		blockCmds[cmd] = false
		self._blockingNum = self._blockingNum - 1

		if self._blockingNum <= 0 then
			WaitingView.instance:hide(WaitingView.Flag_BlockMsg)
		end
	end

	local cmds = self._settingProto[extId]
	local cmdCfg

	if cmds then
		cmdCfg = cmds[cmd]
	end

	local isSysCmd = extId == -1
	local isPushCmd = cmdCfg and #cmdCfg == 1
	local isMoveCmd = extId == 4 and cmd == 9
	local isBeatCmd = extId == 1 and cmd == 1
	local isSurveyCmd = extId == 29 and cmd == 1

	if not isSysCmd and not isPushCmd and not isMoveCmd and not isBeatCmd and not isSurveyCmd then
		local fextId, fcmd, fdata = self._sendingQueque:first()

		if fextId and fcmd then
			if fextId == extId and fcmd == cmd then
				self._sendingQueque:dequeue()
			elseif self._sendingQueque:contain(extId, cmd) then
				if enableDebug then
					self._sendingQueque:dumpMsg()
				end

				self._sendingQueque:remove(extId, cmd)
				printWarn(string.format("%s message order error,fextId=%s&fcmd=%s,receiveId=%s&receiveCmd=%s", LogTag.NETWORK, fextId, fcmd, extId, cmd))
			else
				printWarn(string.format("%s message order error(nonexist request),fextId=%s&fcmd=%s,receiveId=%s&receiveCmd=%s", LogTag.NETWORK, fextId, fcmd, extId, cmd))

				return false
			end
		end
	end

	if self._lastSendExtId == extId and self._lastSendCmd == cmd then
		self._lastSendExtId = false
		self._lastSendCmd = false
		self._lastSendTime = false
	end

	if self._gettingLostMsg and extId ~= -1 then
		self._lostMsgCounter = self._lostMsgCounter + 1
	end

	return true
end

function MsgFlowMgr:registerCustomHandledErrCode(code)
	self._customHandledErrCodes = self._customHandledErrCodes or {}
	self._customHandledErrCodes["rc_" .. code] = true
end

function MsgFlowMgr:onNetConnected()
	self._isConnected = true

	settimer(self._checkSendInterval, self._checkTimeOut, self, true)
end

function MsgFlowMgr:onNetDisConnected()
	self._isConnected = false

	removetimer(self._checkTimeOut, self)
end

function MsgFlowMgr:_checkTimeOut()
	if self._lastSendExtId and self._isConnected and not self._reconnecting then
		local now = os.time()

		if now - self._lastSendTime > self._sendTimeOut then
			printInfo(LogTag.NETWORK, "NetConnMgr.instance:disconnect,due to message timeout,last extId&cmd =", self._lastSendExtId, self._lastSendCmd)
			NetConnMgr.instance:disconnect(ConnectionType.Logic)
		end
	end
end

function MsgFlowMgr:onReconnectStart()
	self._reconnecting = true
end

function MsgFlowMgr:onReconnectSucc()
	self._reconnecting = false
end

function MsgFlowMgr:startListenLostMsg()
	self._gettingLostMsg = true
	self._lostMsgCounter = 0
end

function MsgFlowMgr:clearBlockMsg()
	self._blockedMap = {}
	self._lastSendExtId = false
	self._lastSendCmd = false
	self._lastSendTime = false

	self._sendingQueque:clear()

	self._reconnecting = false
	self._blockingNum = 0
end

function MsgFlowMgr:stopListenLostMsg()
	self._gettingLostMsg = false

	print("lost msg count=", self._lostMsgCounter)

	local entry = self._sendingQueque._head._next

	while entry do
		print("resend msg:", entry.extId, entry.cmd, entry.data)
		NetConnMgr.instance:forceSendMsg(entry.extId, entry.cmd, entry.data, ConnectionType.Logic)

		if not entry._next then
			self._lastSendExtId = entry.extId
			self._lastSendCmd = entry.cmd
			self._lastSendTime = os.time()
		end

		entry = entry._next
	end
end

function MsgFlowMgr._comp(a, b)
	return a.id > b.id
end

function MsgFlowMgr:getCurDownTag()
	return self._curDownTag
end

function MsgFlowMgr:setIgoreOrderMsg(extId, cmdId)
	self._igoreOrderMsgs = self._gettingLostMsg or {}
	self._igoreOrderMsgs[extId] = self._igoreOrderMsgs[extId] or {}
	self._igoreOrderMsgs[extId][cmdId] = true
end

function MsgFlowMgr:isIgoreOrderMsg(extId, cmdId)
	return self._igoreOrderMsgs and self._igoreOrderMsgs[extId] and self._igoreOrderMsgs[extId][cmdId]
end

function MsgFlowMgr:ignoreAutoShowFloatMsg(extId, cmd)
	self._ignoreAutoShowFloatMsgList[extId] = self._ignoreAutoShowFloatMsgList[extId] or {}
	self._ignoreAutoShowFloatMsgList[extId][cmd] = true
end

function MsgFlowMgr:_getIgnoreAutoShowFloatMsg(extId, cmd)
	if self._ignoreAutoShowFloatMsgList[extId] and self._ignoreAutoShowFloatMsgList[extId][cmd] then
		return true
	end

	return false
end

function MsgFlowMgr:setCanForcePrintCmd(flag)
	self._canForcePrintCmd = flag
end

MsgFlowMgr.instance = MsgFlowMgr.New()

return MsgFlowMgr
