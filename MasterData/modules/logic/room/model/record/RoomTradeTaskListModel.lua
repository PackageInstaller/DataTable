-- chunkname: @modules/logic/room/model/record/RoomTradeTaskListModel.lua

module("modules.logic.room.model.record.RoomTradeTaskListModel", package.seeall)

local RoomTradeTaskListModel = class("RoomTradeTaskListModel", ListScrollModel)

function RoomTradeTaskListModel:setMoList(level)
	local moList = RoomTradeTaskModel.instance:getLevelTaskMo(level) or {}

	if LuaUtil.tableNotEmpty(moList) then
		table.sort(moList, self.sort)
	end

	self:setList(moList)

	return moList
end

function RoomTradeTaskListModel.sort(a, b)
	local aCo = a.co
	local bCo = b.co

	if a.hasFinish ~= b.hasFinish then
		return b.hasFinish
	end

	if aCo and bCo then
		return aCo.sortId < bCo.sortId
	end

	return a.id < b.id
end

function RoomTradeTaskListModel:getNewFinishTaskIds(level)
	local ids = {}
	local moList = RoomTradeTaskModel.instance:getLevelTaskMo(level)

	if moList then
		for _, mo in ipairs(moList) do
			if mo.new then
				table.insert(ids, mo.id)
			end
		end
	end

	return ids
end

function RoomTradeTaskListModel:getFinishOrNotTaskIds(level, isFinish)
	local ids = {}
	local moList = RoomTradeTaskModel.instance:getLevelTaskMo(level)

	if moList then
		for _, mo in ipairs(moList) do
			if mo:isFinish() == isFinish then
				table.insert(ids, mo.id)
			end
		end
	end

	return ids
end

RoomTradeTaskListModel.instance = RoomTradeTaskListModel.New()

return RoomTradeTaskListModel
