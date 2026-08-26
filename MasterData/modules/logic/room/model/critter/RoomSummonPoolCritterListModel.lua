-- chunkname: @modules/logic/room/model/critter/RoomSummonPoolCritterListModel.lua

module("modules.logic.room.model.critter.RoomSummonPoolCritterListModel", package.seeall)

local RoomSummonPoolCritterListModel = class("RoomSummonPoolCritterListModel", ListScrollModel)

function RoomSummonPoolCritterListModel:setDataList(critterMos)
	table.sort(critterMos, self._sortFunction)
	self:setList(critterMos)
end

function RoomSummonPoolCritterListModel._sortFunction(a, b)
	local aisNull = a:getPoolCount() <= 0
	local bisNull = b:getPoolCount() <= 0

	if aisNull ~= bisNull then
		return bisNull
	end

	return a.rare > b.rare
end

RoomSummonPoolCritterListModel.instance = RoomSummonPoolCritterListModel.New()

return RoomSummonPoolCritterListModel
