-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/config/DivineCiYuanConfig.lua

module("logic.extensions.divineciyuan.config.DivineCiYuanConfig", package.seeall)

local DivineCiYuanConfig = class("DivineCiYuanConfig", BaseConfig)

function DivineCiYuanConfig:onInit()
	DivineCiYuanConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function DivineCiYuanConfig:getNames()
	return {
		"divine_ci_yuan_challenge_activity",
		"divine_ci_yuan_extreme_tab",
		"divine_ci_yuan_extreme_stage",
		"divine_ci_yuan_universal_stage",
		"divine_ci_yuan_universal_signin",
		"divine_ci_yuan_universal_signin_price",
		"divine_ci_yuan_buff",
		"divine_ci_yuan_monster",
		"divine_ci_yuan_creeps"
	}
end

function DivineCiYuanConfig:handleConfig(name, content)
	if name == "divine_ci_yuan_challenge_activity" then
		self._divineCiYuanActCfg = content
	elseif name == "divine_ci_yuan_extreme_tab" then
		self._divineCiYuanExtremeTabCfg = content
	elseif name == "divine_ci_yuan_extreme_stage" then
		self._divineCiYuanExtremeStageCfg = content
	elseif name == "divine_ci_yuan_universal_stage" then
		self._divineCiYuanUniversalStageCfg = content
	elseif name == "divine_ci_yuan_universal_signin" then
		self._divineCiYuanUniversalSignCfg = content
	elseif name == "divine_ci_yuan_universal_signin_price" then
		self._divineCiYuanUniversalPriceCfg = content
	elseif name == "divine_ci_yuan_buff" then
		self._divineCiYuanBuffCfg = content
	elseif name == "divine_ci_yuan_monster" then
		self._divineCiYuanMonsterCfg = content
	elseif name == "divine_ci_yuan_creeps" then
		self._divineCiYuanCreepsCfg = content
	end
end

function DivineCiYuanConfig:getActCfgById(activityId)
	return self._divineCiYuanActCfg[activityId]
end

function DivineCiYuanConfig:getActRuleKey(activityId, fieldName)
	return self._divineCiYuanActCfg[activityId][fieldName]
end

function DivineCiYuanConfig:getTabCfg(activityId)
	return self._divineCiYuanExtremeTabCfg[activityId]
end

function DivineCiYuanConfig:getTabCfgById(activityId, tabId)
	return self._divineCiYuanExtremeTabCfg[activityId][tabId]
end

function DivineCiYuanConfig:getExtremeStageCfg(activityId, tabId)
	return self._divineCiYuanExtremeStageCfg[activityId][tabId]
end

function DivineCiYuanConfig:getExtremeStageCfgById(activityId, tabId, stageId)
	return self._divineCiYuanExtremeStageCfg[activityId][tabId][stageId]
end

function DivineCiYuanConfig:getBuffCfg(buffId)
	return self._divineCiYuanBuffCfg[buffId]
end

function DivineCiYuanConfig:getBuffPlaneCfg(buffPlanId)
	local cfg = {}

	for _, v in ipairs(self._divineCiYuanBuffCfg) do
		if v.buffPlanId == buffPlanId then
			table.insert(cfg, v)
		end
	end

	return cfg
end

function DivineCiYuanConfig:getBuffCfgById(buffId, buffPlanId)
	return self._divineCiYuanBuffCfg[buffId][buffPlanId]
end

function DivineCiYuanConfig:getCreepCfg(creepsMasterId)
	return self._divineCiYuanCreepsCfg[creepsMasterId]
end

function DivineCiYuanConfig:getCreepCfgByPos(creepsMasterId, posId)
	for _, v in pairs(self._divineCiYuanCreepsCfg[creepsMasterId]) do
		if v.posId == posId then
			return v
		end
	end
end

function DivineCiYuanConfig:getUniversalAllStageCfg(activityId)
	return self._divineCiYuanUniversalStageCfg[activityId]
end

function DivineCiYuanConfig:getUniversalStageCfg(activityId, tabId)
	return self._divineCiYuanUniversalStageCfg[activityId][tabId]
end

function DivineCiYuanConfig:getUniversalStageCfgById(activityId, tabId, bossId)
	return self._divineCiYuanUniversalStageCfg[activityId][tabId][bossId]
end

function DivineCiYuanConfig:getMonsterCfg(creepsMasterId)
	return self._divineCiYuanMonsterCfg[creepsMasterId]
end

function DivineCiYuanConfig:getUniversalAllSignCfg(activityId)
	return self._divineCiYuanUniversalSignCfg[activityId]
end

function DivineCiYuanConfig:getUniversalSignCfg(activityId, tabId)
	if self._divineCiYuanUniversalSignCfg[activityId] then
		return self._divineCiYuanUniversalSignCfg[activityId][tabId]
	end
end

function DivineCiYuanConfig:getUniversalSignCfgById(activityId, tabId, days)
	if self._divineCiYuanUniversalSignCfg[activityId] and self._divineCiYuanUniversalSignCfg[activityId][tabId] then
		return self._divineCiYuanUniversalSignCfg[activityId][tabId][days]
	end
end

function DivineCiYuanConfig:getUniversalSignPriceCfg(activityId)
	return self._divineCiYuanUniversalPriceCfg[activityId]
end

DivineCiYuanConfig.instance = DivineCiYuanConfig.New()

return DivineCiYuanConfig
