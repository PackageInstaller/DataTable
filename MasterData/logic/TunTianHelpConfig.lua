-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianhelp/config/TunTianHelpConfig.lua

module("logic.extensions.tuntianhelp.config.TunTianHelpConfig", package.seeall)

local TunTianHelpConfig = class("TunTianHelpConfig", BaseConfig)

function TunTianHelpConfig:onInit()
	TunTianHelpConfig.super.onInit(self)
end

function TunTianHelpConfig:getNames()
	return {
		"tun_tian_help_activity",
		"tun_tian_help_prize",
		"tun_tian_help_summary_base",
		"tun_tian_help_summary_jump",
		"tun_tian_help_rule"
	}
end

function TunTianHelpConfig:handleConfig(name, content)
	if name == "tun_tian_help_activity" then
		self._tthActBaseCfg = content
	elseif name == "tun_tian_help_prize" then
		self._tthPrizeCfg = content
	elseif name == "tun_tian_help_summary_base" then
		self._tthSummaryBaseCfg = content
	elseif name == "tun_tian_help_summary_jump" then
		self._tthSummaryJumpCfg = content
	elseif name == "tun_tian_help_rule" then
		self._tthRuleCfg = content
	end
end

function TunTianHelpConfig:getTthActBaseData(activityId)
	return self._tthActBaseCfg[activityId]
end

function TunTianHelpConfig:getTthPrizeDataList(activityId)
	return self._tthPrizeCfg[activityId]
end

function TunTianHelpConfig:getTthPrizeData(activityId, prizeId)
	return self._tthPrizeCfg[activityId][prizeId]
end

function TunTianHelpConfig:getTthSummaryBaseDataList()
	return self._tthSummaryBaseCfg.dataList
end

function TunTianHelpConfig:getTthSummaryBaseData(jumpPlanId)
	return self._tthSummaryBaseCfg[jumpPlanId]
end

function TunTianHelpConfig:getTthSummaryJumpDataList(jumpPlanId)
	return self._tthSummaryJumpCfg[jumpPlanId]
end

function TunTianHelpConfig:getTthSummaryJumpData(jumpPlanId, jumpId)
	return self._tthSummaryJumpCfg[jumpPlanId][jumpId]
end

function TunTianHelpConfig:getTthRuleDataList(rulePlanId)
	return self._tthRuleCfg[rulePlanId]
end

function TunTianHelpConfig:getTthRuleData(rulePlanId, ruleId)
	return self._tthRuleCfg[rulePlanId][ruleId]
end

TunTianHelpConfig.instance = TunTianHelpConfig.New()

return TunTianHelpConfig
