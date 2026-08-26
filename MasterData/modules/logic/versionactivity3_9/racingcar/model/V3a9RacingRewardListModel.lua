-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingRewardListModel.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingRewardListModel", package.seeall)

local V3a9RacingRewardListModel = class("V3a9RacingRewardListModel", ListScrollModel)

function V3a9RacingRewardListModel:refreshList(mileStoneId)
	local list = MileStoneConfig.instance:getBonusList(mileStoneId)

	self:setList(list)
end

function V3a9RacingRewardListModel:getPoint(milestoneId)
	return MileStoneUtil.getMileStoneProgress(milestoneId) or 0
end

V3a9RacingRewardListModel.instance = V3a9RacingRewardListModel.New()

return V3a9RacingRewardListModel
