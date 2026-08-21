-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/msgdebugger/MsgDebuggerCollectModel.lua

module("logic.extensions.msgdebugger.MsgDebuggerCollectModel", package.seeall)

local M = class("MsgDebuggerCollectModel", BaseListModel)

function M:onInit()
	M.super.onInit(self)

	self._hasBlockMsgList = {}
	self._inShowCollectList = false
end

function M:addHasBlockMsg(msgDebuggerMO)
	msgDebuggerMO:setIsBlock(true)
	table.insert(self._hasBlockMsgList, msgDebuggerMO)
end

function M:getHasBlockMsgList()
	return self._hasBlockMsgList
end

function M:getHasBlockMsgCount()
	local count = 0

	for i = 1, #self._hasBlockMsgList do
		local msgMO = self._hasBlockMsgList[i]

		if not MsgDebuggerConfig.IgnoreExtCmdList[msgMO.extCmdValue] then
			count = count + 1
		end
	end

	return count
end

function M:clearHasBlockMsgList()
	for i = 1, #self._hasBlockMsgList do
		self._hasBlockMsgList[i]:setIsBlock(false)
	end

	self:updateData()
	table.clear(self._hasBlockMsgList)
end

function M:clearSentMsg()
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

function M:checkAddMo(msgMO)
	local moList = self:getMoList()

	for k, v in pairs(moList) do
		if v.ext == msgMO.ext and v.cmd == msgMO.cmd then
			return
		end
	end

	self:addMoAt(msgMO, 1)
end

function M:setInShowCollectList(value)
	self._inShowCollectList = value
end

function M:getInShowCollectList()
	return self._inShowCollectList
end

M.instance = M.New()

return M
