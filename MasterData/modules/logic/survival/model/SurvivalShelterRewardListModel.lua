-- chunkname: @modules/logic/survival/model/SurvivalShelterRewardListModel.lua

module("modules.logic.survival.model.SurvivalShelterRewardListModel", package.seeall)

local SurvivalShelterRewardListModel = class("SurvivalShelterRewardListModel", ListScrollModel)

function SurvivalShelterRewardListModel:refreshList()
	local list = SurvivalConfig.instance:getRewardList() or {}

	if #list > 1 then
		table.sort(list, SortUtil.keyLower("score"))
	end

	self:setList(list)
end

SurvivalShelterRewardListModel.instance = SurvivalShelterRewardListModel.New()

return SurvivalShelterRewardListModel
