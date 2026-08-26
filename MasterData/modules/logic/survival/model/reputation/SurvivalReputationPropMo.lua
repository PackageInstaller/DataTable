-- chunkname: @modules/logic/survival/model/reputation/SurvivalReputationPropMo.lua

module("modules.logic.survival.model.reputation.SurvivalReputationPropMo", package.seeall)

local SurvivalReputationPropMo = pureTable("SurvivalReputationPropMo")

function SurvivalReputationPropMo:setData(reputationProp)
	self.prop = reputationProp
	self.survivalShopMo = self.survivalShopMo or SurvivalShopMo.New()

	self.survivalShopMo:init(self.prop.shop, self.prop.reputationId, self.prop.reputationLevel)
end

function SurvivalReputationPropMo:onReceiveSurvivalReputationRewardReply(level)
	if not tabletool.indexOf(self.prop.gain, level) then
		table.insert(self.prop.gain, level)
	end
end

function SurvivalReputationPropMo:getReputationLevel()
	return self.prop.reputationLevel
end

function SurvivalReputationPropMo:isMaxLevel()
	local maxLevel = SurvivalConfig.instance:getReputationMaxLevel(self.prop.reputationId)

	return maxLevel <= self.prop.reputationLevel
end

function SurvivalReputationPropMo:isGainFreeReward(level)
	return tabletool.indexOf(self.prop.gain, level) ~= nil
end

function SurvivalReputationPropMo:haveFreeReward()
	for level = 1, self.prop.reputationLevel do
		if not tabletool.indexOf(self.prop.gain, level) then
			return true
		end
	end

	return false
end

function SurvivalReputationPropMo:getLevelBkg()
	local level = self.prop.reputationLevel

	return "survival_commit_levelbg_" .. level
end

function SurvivalReputationPropMo:getLevelProgressBkg(isFront)
	local level = self.prop.reputationLevel
	local index

	return string.format("survival_commit_progressbg%s_%s", level, isFront and 1 or 2)
end

return SurvivalReputationPropMo
