-- chunkname: @modules/logic/room/model/map/RoomProductionLineListModel.lua

module("modules.logic.room.model.map.RoomProductionLineListModel", package.seeall)

local RoomProductionLineListModel = class("RoomProductionLineListModel", ListScrollModel)

function RoomProductionLineListModel:updatePartLines(partId)
	local config = RoomConfig.instance:getProductionPartConfig(partId)
	local list = {}

	for i, v in ipairs(config.productionLines) do
		local lineMO = RoomProductionModel.instance:getLineMO(v)

		table.insert(list, lineMO)
	end

	self:setList(list)
end

RoomProductionLineListModel.instance = RoomProductionLineListModel.New()

return RoomProductionLineListModel
