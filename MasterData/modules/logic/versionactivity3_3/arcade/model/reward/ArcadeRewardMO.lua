-- chunkname: @modules/logic/versionactivity3_3/arcade/model/reward/ArcadeRewardMO.lua

module("modules.logic.versionactivity3_3.arcade.model.reward.ArcadeRewardMO", package.seeall)

local ArcadeRewardMO = class("ArcadeRewardMO")

function ArcadeRewardMO:ctor(co)
	self.co = co
	self.id = co.id
	self.score = co.score
end

function ArcadeRewardMO:onGain(isGain)
	self._isGain = isGain
end

function ArcadeRewardMO:getScore()
	return self.score
end

function ArcadeRewardMO:isGainReward()
	return self._isGain
end

function ArcadeRewardMO:getRewardState()
	if self._isGain then
		return ArcadeEnum.RewardItemStatus.Gained
	end

	if self:getScore() <= ArcadeOutSizeModel.instance:getScore() then
		return ArcadeEnum.RewardItemStatus.CanGet
	end

	return ArcadeEnum.RewardItemStatus.Normal
end

return ArcadeRewardMO
