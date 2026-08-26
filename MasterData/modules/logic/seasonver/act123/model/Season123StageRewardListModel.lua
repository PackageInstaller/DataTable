-- chunkname: @modules/logic/seasonver/act123/model/Season123StageRewardListModel.lua

module("modules.logic.seasonver.act123.model.Season123StageRewardListModel", package.seeall)

local Season123StageRewardListModel = class("Season123StageRewardListModel", ListScrollModel)

function Season123StageRewardListModel:refreshList(activityId, stage)
	local dataList = {}
	local seasonMO = Season123Model.instance:getActInfo(activityId)
	local stageMo = seasonMO:getStageMO(stage)
	local curStar = stageMo:getProgressStar()
	local list = Season123Config.instance:getStageRewardList(activityId, stage)

	for i, v in ipairs(list) do
		local state = 1

		state = stageMo:isBonusGet(v.bonusId) and 2 or curStar >= v.star and 1 or 0

		table.insert(dataList, {
			index = i,
			config = v,
			state = state
		})
	end

	self:setList(dataList)
end

Season123StageRewardListModel.instance = Season123StageRewardListModel.New()

return Season123StageRewardListModel
