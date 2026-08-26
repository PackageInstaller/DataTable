-- chunkname: @modules/logic/room/model/record/RoomHandBookListModel.lua

module("modules.logic.room.model.record.RoomHandBookListModel", package.seeall)

local RoomHandBookListModel = class("RoomHandBookListModel", ListScrollModel)

function RoomHandBookListModel:init()
	local moList = {}
	local list = lua_critter.configList

	for _, handBookCo in ipairs(list) do
		local mo = RoomHandBookMo.New()

		mo:init(handBookCo)
		table.insert(moList, mo)
	end

	table.sort(moList, RoomHandBookListModel.sort)
	self:setList(moList)
	RoomHandBookModel.instance:setSelectMo(moList[1])
end

function RoomHandBookListModel.sort(x, y)
	local xvalue = x:checkGotCritter() and 2 or 1
	local yvalue = y:checkGotCritter() and 2 or 1

	if xvalue ~= yvalue then
		return yvalue < xvalue
	else
		return x.id < y.id
	end
end

function RoomHandBookListModel:reverseCardBack(state)
	local moList = self:getList()

	for index, mo in ipairs(moList) do
		mo:setReverse(state)
	end
end

function RoomHandBookListModel:clearItemNewState(critterId)
	local mo = self:getById(critterId)

	mo:clearNewState()
	self:onModelUpdate()
end

function RoomHandBookListModel:setMutate(info)
	if not info then
		return
	end

	local mo = self:getById(info.id)

	mo:setSpeicalSkin(info.UseSpecialSkin)
end

RoomHandBookListModel.instance = RoomHandBookListModel.New()

return RoomHandBookListModel
