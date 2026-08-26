-- chunkname: @modules/logic/milestone/model/MileStoneListModel.lua

module("modules.logic.milestone.model.MileStoneListModel", package.seeall)

local MileStoneListModel = class("MileStoneListModel", ListScrollModel)

function MileStoneListModel:refreshList(mileStoneId)
	local list = MileStoneConfig.instance:getBonusList(mileStoneId)

	self:setList(list)
end

MileStoneListModel.instance = MileStoneListModel.New()

return MileStoneListModel
