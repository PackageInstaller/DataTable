-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/msgdebugger/MsgDebuggerModel.lua

module("logic.extensions.msgdebugger.MsgDebuggerModel", package.seeall)

local MsgDebuggerModel = class("MsgDebuggerModel", BaseListModel)

function MsgDebuggerModel:onInit()
	MsgDebuggerModel.super.onInit(self)

	self._hasBlockMsgList = {}
end

function MsgDebuggerModel:addHasBlockMsg(msgDebuggerMO)
	msgDebuggerMO:setIsBlock(true)
	table.insert(self._hasBlockMsgList, msgDebuggerMO)
end

function MsgDebuggerModel:getHasBlockMsgList()
	return self._hasBlockMsgList
end

function MsgDebuggerModel:getHasBlockMsgCount()
	local count = 0

	for i = 1, #self._hasBlockMsgList do
		local msgMO = self._hasBlockMsgList[i]

		if not MsgDebuggerConfig.IgnoreExtCmdList[msgMO.extCmdValue] then
			count = count + 1
		end
	end

	return count
end

function MsgDebuggerModel:clearHasBlockMsgList()
	for i = 1, #self._hasBlockMsgList do
		self._hasBlockMsgList[i]:setIsBlock(false)
	end

	table.clear(self._hasBlockMsgList)
end

function MsgDebuggerModel:clearSentMsg()
	local oldList = self:getMoList()
	local newList = {}

	for i = 1, #oldList do
		local msgMO = oldList[i]

		if msgMO.isBlock then
			table.insert(newList, msgMO)
		end
	end

	self:setMoList(newList)
end

MsgDebuggerModel.instance = MsgDebuggerModel.New()

return MsgDebuggerModel
