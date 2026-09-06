-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/config/SummerLotteryConfig.lua

module("logic.extensions.summerlottery.config.SummerLotteryConfig", package.seeall)

local SummerLotteryConfig = class("SummerLotteryConfig", BaseConfig)

SummerLotteryConfig.ChouKaQualityUrls = {
	"20220701/chouka/shichou/lanse.prefab",
	"20220701/chouka/shichou/zise.prefab",
	"20220701/chouka/shichou/jinse.prefab",
	"20220701/chouka/shichou/hongse.prefab"
}
SummerLotteryConfig.TuoWeiQualityUrls = {
	"20220701/chouka/shichou/lanse_tuowei.prefab",
	"20220701/chouka/shichou/zise_tuowei.prefab",
	"20220701/chouka/shichou/jinse_tuowei.prefab",
	"20220701/chouka/shichou/hongse_tuowei.prefab"
}
SummerLotteryConfig.ChouKaFirstEffect = "20220701/chouka/shichou/fx_chouka_shichou_zxl_07.prefab"
SummerLotteryConfig.DefaultLuoXuanEffect = "20220701/chouka/shichou/fx_chouka_shichou_zxl_08.prefab"

function SummerLotteryConfig:onInit()
	SummerLotteryConfig.super.onInit(self)

	self._summer_lottery = nil
	self._summer_lottery_pool = nil
	self._summer_lottery_pool_prize = nil
	self._summer_lottery_task = nil
	self._summer_lottery_progress_prize = nil
	self._lottery_prize_client_show_config = nil
	self._lottery_prize_client_rule_config = nil
	self._summer_lottery_client_common = nil
	self._summer_lottery_show = nil
end

function SummerLotteryConfig:getNames()
	return {
		"summer_lottery",
		"summer_lottery_pool",
		"summer_lottery_pool_prize",
		"summer_lottery_task",
		"summer_lottery_progress_prize",
		"lottery_prize_client_show_config",
		"lottery_prize_client_rule_config",
		"summer_lottery_client_common",
		"summer_lottery_show",
		"summer_lottery_koi_prize"
	}
end

function SummerLotteryConfig:handleConfig(name, content)
	if name == "summer_lottery" then
		self._summer_lottery = content
	elseif name == "summer_lottery_pool" then
		self._summer_lottery_pool = content
	elseif name == "summer_lottery_pool_prize" then
		self._summer_lottery_pool_prize = content
	elseif name == "summer_lottery_task" then
		self._summer_lottery_task = content
	elseif name == "summer_lottery_progress_prize" then
		self._summer_lottery_progress_prize = content
	elseif name == "lottery_prize_client_show_config" then
		self._lottery_prize_client_show_config = content
	elseif name == "lottery_prize_client_rule_config" then
		self._lottery_prize_client_rule_config = content
	elseif name == "summer_lottery_client_common" then
		self._summer_lottery_client_common = content
	elseif name == "summer_lottery_show" then
		self._summer_lottery_show = content
	elseif name == "summer_lottery_koi_prize" then
		self._summer_lottery_koi_prize = content
	end
end

function SummerLotteryConfig:getSummerLotteryConfig(activityId)
	return self._summer_lottery[activityId]
end

function SummerLotteryConfig:getSummerLotteryPoolConfig(poolPlanId)
	return self._summer_lottery_pool[poolPlanId]
end

function SummerLotteryConfig:getSummerLotteryPrizeConfig(poolPrizePlanId, poolPrizeId)
	local pool = self._summer_lottery_pool_prize[poolPrizePlanId]

	if pool then
		return pool[poolPrizeId]
	end

	return nil
end

function SummerLotteryConfig:getSummerLotteryAllPrize(poolPrizePlanId)
	return self._summer_lottery_pool_prize[poolPrizePlanId]
end

function SummerLotteryConfig:getSummerLotteryPoolConfig(poolPlanId)
	return self._summer_lottery_pool[poolPlanId]
end

function SummerLotteryConfig:getTaskCfgs(taskPlanId)
	return self._summer_lottery_task[taskPlanId]
end

function SummerLotteryConfig:getTaskConf(taskPlanId, taskId)
	if self._summer_lottery_task[taskPlanId] then
		return self._summer_lottery_task[taskPlanId][taskId]
	end

	return nil
end

function SummerLotteryConfig:getTaskProgressConfs(progressPlanId)
	return self._summer_lottery_progress_prize[progressPlanId]
end

function SummerLotteryConfig:getCommonLotteryRuleConf(poolId)
	return self._lottery_prize_client_rule_config[poolId]
end

function SummerLotteryConfig:getCommonLotteryShowConfs(poolId)
	return self._lottery_prize_client_show_config[poolId]
end

function SummerLotteryConfig:getCommonValue(key)
	local conf = self._summer_lottery_client_common[key]

	if conf then
		return conf.value
	end

	return ""
end

function SummerLotteryConfig:getPrizeShowConfs(poolPrizePlanId)
	return self._summer_lottery_show[poolPrizePlanId]
end

function SummerLotteryConfig:getPrizeShowConfByGroupId(poolPrizePlanId, groupId)
	if self._summer_lottery_show[poolPrizePlanId] then
		return self._summer_lottery_show[poolPrizePlanId][groupId]
	end
end

function SummerLotteryConfig:getKoiPrize(koiPrizePlanId, koiPrizeId)
	if self._summer_lottery_koi_prize[koiPrizePlanId] then
		return self._summer_lottery_koi_prize[koiPrizePlanId][koiPrizeId]
	end
end

function SummerLotteryConfig:getKoiPrizes(koiPrizePlanId)
	return self._summer_lottery_koi_prize[koiPrizePlanId]
end

SummerLotteryConfig.instance = SummerLotteryConfig.New()

return SummerLotteryConfig
