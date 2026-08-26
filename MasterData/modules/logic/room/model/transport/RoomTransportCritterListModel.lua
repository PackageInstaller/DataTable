-- chunkname: @modules/logic/room/model/transport/RoomTransportCritterListModel.lua

module("modules.logic.room.model.transport.RoomTransportCritterListModel", package.seeall)

local RoomTransportCritterListModel = class("RoomTransportCritterListModel", ListScrollModel)

function RoomTransportCritterListModel:setCritterList()
	local moList = {}
	local critterMOList = CritterModel.instance:getAllCritters()

	for i = 1, #critterMOList do
		local critterMO = critterMOList[i]

		if critterMO and critterMO:isMaturity() then
			table.insert(moList, critterMO)
		end
	end

	self:setList(moList)
end

function RoomTransportCritterListModel:getSelect()
	return self._selectId
end

function RoomTransportCritterListModel:_refreshSelect()
	local selectMO = self:getById(self._selectId)

	for i, view in ipairs(self._scrollViews) do
		view:setSelect(selectMO)
	end
end

function RoomTransportCritterListModel:setSelect(id)
	if self._selectId ~= id then
		self._selectId = id

		self:_refreshSelect()
	end
end

RoomTransportCritterListModel.instance = RoomTransportCritterListModel.New()

return RoomTransportCritterListModel
