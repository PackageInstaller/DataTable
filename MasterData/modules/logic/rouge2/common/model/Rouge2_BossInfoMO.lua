-- chunkname: @modules/logic/rouge2/common/model/Rouge2_BossInfoMO.lua

module("modules.logic.rouge2.common.model.Rouge2_BossInfoMO", package.seeall)

local Rouge2_BossInfoMO = pureTable("Rouge2_BossInfoMO")

function Rouge2_BossInfoMO:init(info)
	self.bossId = info.bossId
	self.allScore = info.allScore
	self.maxScore = info.maxScore
	self.gainReward = info.gainReward
end

function Rouge2_BossInfoMO:getRewardStatus(rewardId)
	local status = Rouge2_OutsideEnum.BossRewardStatus.Lock
	local rewardCo = Rouge2_BossBattleConfig.instance:getRewardConfig(rewardId)

	if rewardCo then
		if not rewardCo.score then
			if rewardCo.score <= self.maxScore then
				local hasGain = self:isGainReward(rewardId)

				status = hasGain and Rouge2_OutsideEnum.BossRewardStatus.HasGet or Rouge2_OutsideEnum.BossRewardStatus.CanGet
			end
		end
	end

	return status
end

function Rouge2_BossInfoMO:isGainReward(rewardId)
	return tabletool.indexOf(self.gainReward, rewardId) ~= nil
end

function Rouge2_BossInfoMO:getBossId()
	return self.bossId
end

function Rouge2_BossInfoMO:getAllScore()
	return self.allScore
end

function Rouge2_BossInfoMO:getMaxScore()
	return self.maxScore
end

function Rouge2_BossInfoMO:hasAnyRewardCanGet()
	local rewardList = Rouge2_BossBattleConfig.instance:getRewardListByBossId(self.bossId)

	if not rewardList then
		return
	end

	for _, reweardCo in ipairs(rewardList) do
		if self:getRewardStatus(reweardCo.id) == Rouge2_OutsideEnum.BossRewardStatus.CanGet then
			return true
		end
	end
end

return Rouge2_BossInfoMO
