-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/msgdebugger/MsgDebugger.lua

module("logic.extensions.msgdebugger.MsgDebugger", package.seeall)

local MsgDebugger = class("MsgDebugger")

MsgDebugger.EvtStartBlock = 101
MsgDebugger.EvtCancelBlock = 102
MsgDebugger.EvtSend = 103
MsgDebugger.EvtClear = 104
MsgDebugger.EvtEnterMsg = 1001
MsgDebugger.EvtExitMsg = 1002
MsgDebugger.EvtModifyParam = 1003
MsgDebugger.EvtBlockOneMsg = 1004

function MsgDebugger:ctor()
	self._toBlockExtCmdDict = {}
	self._isShow = false
	self._toBlockAll = false
	self.dispatcher = {}
	self.parentGO = nil
	self._isInit = false

	NotifyDispatcher.extend(self.dispatcher)
end

function MsgDebugger:init()
	if not self._isInit then
		self._isInit = true

		self.registerLocalNotify(self, MsgDebugger.EvtStartBlock, self._onStartBlockMsg, self)
		self.registerLocalNotify(self, MsgDebugger.EvtCancelBlock, self._onCancelBlockMsg, self)
	end
end

function MsgDebugger:_onStartBlockMsg()
	NetStateDef.MsgMaxWaitTime = 999999999
end

function MsgDebugger:_onCancelBlockMsg()
	NetStateDef.MsgMaxWaitTime = NetStateDef.OrgMsgMaxWaitTime
end

function MsgDebugger:show()
	self._isShow = true
	self.parentGO = goutil.find(MsgDebuggerConfig.UIROOT)

	self:_redefineNetConnMgr()
	MsgDebuggerModel.instance:onInit()
	MsgDebuggerParamModel.instance:onInit()
	MsgDebuggerUI.instance:show()
end

function MsgDebugger:destroy()
	self._isShow = false

	self:cancelBlock()
	self:_resumeNetConnMgr()
	MsgDebuggerModel.instance:onReset()
	MsgDebuggerParamModel.instance:onReset()
	MsgDebuggerUI.instance:destroy()
	MsgDebuggerView.instance:destroy()
	MsgDebuggerModifyView.instance:destroy()
end

function MsgDebugger:isShow()
	return self._isShow
end

function MsgDebugger:registerLocalNotify(name, handler, handlerObj, priority)
	self.dispatcher:addListener(name, handler, handlerObj)
end

function MsgDebugger:unregisterLocalNotify(name, handler, handlerObj)
	self.dispatcher:removeListener(name, handler, handlerObj)
end

function MsgDebugger:localNotify(name, message)
	self.dispatcher:dispatch(name, message)
end

function MsgDebugger:isBlock(ext, cmd)
	if self._toBlockAll then
		return true
	elseif ext and cmd then
		local extCmdValue = ext * 10000 + cmd

		return self._toBlockExtCmdDict[extCmdValue]
	end

	return false
end

function MsgDebugger:startBlock(ext, cmd)
	if ext and cmd then
		local extCmdValue = ext * 10000 + cmd

		self._toBlockExtCmdDict[extCmdValue] = NetConnMgr.instance:_getPbUpStructName(ext, cmd)
	else
		self._toBlockAll = true
	end

	self:localNotify(MsgDebugger.EvtStartBlock)
end

function MsgDebugger:cancelBlock(ext, cmd)
	self:send()

	if ext and cmd then
		local extCmdValue = ext * 10000 + cmd

		self._toBlockExtCmdDict[extCmdValue] = nil
	else
		table.clear(self._toBlockExtCmdDict)

		self._toBlockAll = false
	end

	self:localNotify(MsgDebugger.EvtCancelBlock)
end

function MsgDebugger:send()
	if self._function_NetConnMgr_SendMsg then
		local list = MsgDebuggerModel.instance:getHasBlockMsgList()

		for i = 1, #list do
			local one = list[i]

			self._function_NetConnMgr_SendMsg(NetConnMgr.instance, one.msg, one.connType)
			self:_onSendMsg(one)
		end
	end

	MsgDebuggerModel.instance:clearHasBlockMsgList()
	self:localNotify(MsgDebugger.EvtSend)
end

function MsgDebugger:sendOneMore(msgMO)
	NetConnMgr.instance:sendMsg(msgMO.msg, msgMO.connType)
	self:send()
end

function MsgDebugger:clear()
	MsgDebuggerModel.instance:clearSentMsg()
	self:localNotify(MsgDebugger.EvtSend)
end

function MsgDebugger:_redefineNetConnMgr()
	if self._hasRedefine then
		return
	end

	local msgDebugger = self

	self._hasRedefine = true
	self._function_NetConnMgr_SendMsg = NetConnMgr.sendMsg

	function NetConnMgr:sendMsg(msg, connType)
		local structName = msg._cname
		local extCmd = NetConnMgr.instance._requestExtAndCmdMap[structName]

		if extCmd then
			local pbUpStructName = NetConnMgr.instance:_getPbUpStructName(extCmd[1], extCmd[2])
			local msgMO = MsgDebuggerMO.New()

			if MsgDebuggerConfig.NeedPrintStackTrace then
				local stackTrace = debug.traceback()

				msgMO:init(extCmd[1], extCmd[2], pbUpStructName, ServerTime.now(), msg, MsgDebuggerConfig.NeedPrintStackTrace, connType)

				if msgDebugger:isBlock(extCmd[1], extCmd[2]) then
					if MsgDebuggerConfig.BlockAllWhenBlockOccur then
						msgDebugger._toBlockAll = true
					end

					MsgDebuggerModel.instance:addHasBlockMsg(msgMO)
					msgDebugger:localNotify(MsgDebugger.EvtBlockOneMsg)
				else
					msgDebugger._function_NetConnMgr_SendMsg(self, msg, connType)
					msgDebugger:_onSendMsg(msgMO)
				end

				if not MsgDebuggerConfig.IgnoreExtCmdList[msgMO.extCmdValue] then
					MsgDebuggerModel.instance:addMoAt(msgMO, 1)
				end
			end
		end
	end
end

function MsgDebugger:_resumeNetConnMgr()
	if self._hasRedefine then
		self._hasRedefine = nil
		NetConnMgr.sendMsg = self._function_NetConnMgr_SendMsg
		self._function_NetConnMgr_SendMsg = nil
	end
end

function MsgDebugger:_onSendMsg(msgMO)
	if msgMO.hasModifyValue then
		local paramStr = tostring(msgMO.msg)

		paramStr = string.nilorempty(paramStr) and "no param" or paramStr

		printWarn(string.format("send %d_%d, %s\n%s\n%s", msgMO.ext, msgMO.cmd, msgMO.pbUpStructName, paramStr, debug.traceback()))
	end
end

MsgDebugger.instance = MsgDebugger.New()

return MsgDebugger
