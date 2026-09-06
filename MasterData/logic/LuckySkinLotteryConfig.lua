-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/config/LuckySkinLotteryConfig.lua

module("logic.extensions.luckyskinlottery.config.LuckySkinLotteryConfig", package.seeall)

local LuckySkinLotteryConfig = class("LuckySkinLotteryConfig", BaseConfig)

function LuckySkinLotteryConfig:onInit()
	LuckySkinLotteryConfig.super.onInit(self)

	self._cofigskin_lottery_activitynameCfg = nil
end

function LuckySkinLotteryConfig:getNames()
	return {
		"skin_lottery_activity",
		"skin_lottery_plan_rate",
		"skin_lottery_process_reward",
		"skin_lottery_price_plan",
		"skin_lottery_plan",
		"skin_lottery_process_plan",
		"skin_lottery_cri_plan",
		"skin_lottery_spirit"
	}
end

function LuckySkinLotteryConfig:handleConfig(name, content)
	if name == "skin_lottery_activity" then
		self.skin_lottery_activity = content
	elseif name == "skin_lottery_plan_rate" then
		self._skin_lottery_plan_rate = content
	elseif name == "skin_lottery_process_reward" then
		self._skin_lottery_process_reward = content
	elseif name == "skin_lottery_price_plan" then
		self._skin_lottery_price_plan = content
	elseif name == "skin_lottery_plan" then
		self._skin_lottery_plan = content
	elseif name == "skin_lottery_process_plan" then
		self._skin_lottery_process_plan = content
	elseif name == "skin_lottery_cri_plan" then
		self._skin_lottery_cri_plan = content
	elseif name == "skin_lottery_spirit" then
		self._skin_lottery_spirit = content
	end
end

function LuckySkinLotteryConfig:getOpenActivityCfg()
	if self.skin_lottery_activity == nil then
		return self:actTime(-1)
	end

	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.SkinLottery)

	if cfgs == nil then
		return self:actTime(-2)
	end

	for _, item in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.SkinLottery, item.activityId) then
			return item
		end
	end

	return self:actTime(-3)
end

function LuckySkinLotteryConfig:actTime(key)
	printError("lbc=======(-1:没有拿到活动表，表可能为空；-2:y运营-活动时间(改)这个表有问题，没有对应的活动类型；-3:没有在活动时间)     活动id:", key)

	return key
end

function LuckySkinLotteryConfig:getCfgById(id)
	return self.skin_lottery_activity[id]
end

function LuckySkinLotteryConfig:getSkinPos(petId)
	return self._skin_lottery_spirit[petId].pos
end

function LuckySkinLotteryConfig:getShowPetSkinId(id)
	local cfg = self:getCfgById(id)

	if cfg then
		return cfg.display
	end

	return {}
end

function LuckySkinLotteryConfig:getCriRateShow(lotteryPlan, lotteryNum)
	local cfg = self._skin_lottery_cri_plan[lotteryPlan]

	if cfg then
		return cfg[lotteryNum].criRateShow
	end

	return ""
end

function LuckySkinLotteryConfig:getSkinLotteryPlanCfg(lotteryPlan, curLotteryCount)
	local tem = self:getSkinLotteryPlanRateCfg(lotteryPlan)

	if tem then
		local cfg = self._skin_lottery_plan[tem.lotteryTypePlanId]

		if cfg then
			return cfg[curLotteryCount]
		end
	end

	return {}
end

function LuckySkinLotteryConfig:getSkinLotteryPlanCfgs(lotteryPlan)
	local tem = self:getSkinLotteryPlanRateCfg(lotteryPlan)

	if tem then
		local cfg = self._skin_lottery_plan[tem.lotteryTypePlanId]

		if cfg then
			return cfg
		end
	end

	return {}
end

function LuckySkinLotteryConfig:getProgressPlanCfg(progressPlan)
	if self._skin_lottery_process_plan[progressPlan] then
		return self._skin_lottery_process_plan[progressPlan]
	end

	return {}
end

function LuckySkinLotteryConfig:getRatePlanCfg(ratePlan)
	if self._skin_lottery_cri_plan[ratePlan] then
		return self._skin_lottery_cri_plan[ratePlan]
	end

	return {}
end

function LuckySkinLotteryConfig:getPetPos(id)
	if self._skin_lottery_spirit[id] then
		return self._skin_lottery_spirit[id].pos
	end

	return {
		0,
		0,
		0
	}
end

function LuckySkinLotteryConfig:getPetBgImg(id)
	if self._skin_lottery_spirit[id] then
		return self._skin_lottery_spirit[id].bgImg
	end

	return ""
end

function LuckySkinLotteryConfig:getSkinLotteryPlanRateCfg(lotteryPlan)
	return self._skin_lottery_plan_rate[lotteryPlan]
end

function LuckySkinLotteryConfig:getProgressRewardPlan(lotteryPlan)
	if self._skin_lottery_plan_rate[lotteryPlan] then
		return self._skin_lottery_plan_rate[lotteryPlan].processRewardPlan
	end

	printError("没有拿到进度奖励方案")

	return nil
end

function LuckySkinLotteryConfig:getRewardCfgList(planId)
	if self._skin_lottery_process_reward[planId] then
		return self._skin_lottery_process_reward[planId]
	end

	return {}
end

function LuckySkinLotteryConfig:getRewardCfg(planId, rewardId)
	if self._skin_lottery_process_reward[planId] then
		return self._skin_lottery_process_reward[planId][rewardId]
	end

	return {}
end

function LuckySkinLotteryConfig:getPriceCfg(planId, num)
	if self._skin_lottery_price_plan[planId] then
		return self._skin_lottery_price_plan[planId][num]
	end

	return {}
end

function LuckySkinLotteryConfig:getPricePlanCfg(planId)
	if self._skin_lottery_price_plan[planId] then
		return self._skin_lottery_price_plan[planId]
	end

	return {}
end

function LuckySkinLotteryConfig:isFreePlan(planId)
	local planCfgs = self._skin_lottery_price_plan[planId]

	if planCfgs then
		for _, v in ipairs(planCfgs) do
			if v.freeRate > 0 then
				return true
			end
		end
	end

	return false
end

LuckySkinLotteryConfig.instance = LuckySkinLotteryConfig.New()

return LuckySkinLotteryConfig
