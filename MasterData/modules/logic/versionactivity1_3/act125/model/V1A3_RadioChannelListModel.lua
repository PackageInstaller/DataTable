-- chunkname: @modules/logic/versionactivity1_3/act125/model/V1A3_RadioChannelListModel.lua

module("modules.logic.versionactivity1_3.act125.model.V1A3_RadioChannelListModel", package.seeall)

local V1A3_RadioChannelListModel = class("V1A3_RadioChannelListModel", ListScrollModel)

function V1A3_RadioChannelListModel:setCategoryList(infos)
	local moList = infos and infos or {}

	self:setList(moList)
end

V1A3_RadioChannelListModel.instance = V1A3_RadioChannelListModel.New()

return V1A3_RadioChannelListModel
