-- chunkname: @modules/logic/versionactivity3_3/arcade/model/reward/ArcadeRewardListModel.lua

module("modules.logic.versionactivity3_3.arcade.model.reward.ArcadeRewardListModel", package.seeall)

local ArcadeRewardListModel = class("ArcadeRewardListModel", ListScrollModel)

function ArcadeRewardListModel:refreshList()
	local moList = ArcadeOutSizeModel.instance:getRewardList()

	table.sort(moList, self.score)
	self:setList(moList)
end

function ArcadeRewardListModel.score(a, b)
	return a.co.score < b.co.score
end

ArcadeRewardListModel.instance = ArcadeRewardListModel.New()

return ArcadeRewardListModel
