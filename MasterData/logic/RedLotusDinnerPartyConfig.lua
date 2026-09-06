-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/config/RedLotusDinnerPartyConfig.lua

module("logic.extensions.redlotusdinnerparty.config.RedLotusDinnerPartyConfig", package.seeall)

local RedLotusDinnerPartyConfig = class("RedLotusDinnerPartyConfig", BaseConfig)

function RedLotusDinnerPartyConfig:onInit()
	RedLotusDinnerPartyConfig.super.onInit(self)
end

function RedLotusDinnerPartyConfig:getNames()
	return {
		"red_lotus_gala_activity",
		"red_lotus_gala_perform",
		"red_lotus_gala_sxgame",
		"red_lotus_gala_progress",
		"red_lotus_gala_buy",
		"red_lotus_gala_stage",
		"red_lotus_gala_common"
	}
end

function RedLotusDinnerPartyConfig:handleConfig(name, content)
	if name == "red_lotus_gala_activity" then
		self._red_lotus_gala_activity = content
	elseif name == "red_lotus_gala_perform" then
		self._red_lotus_gala_perform = content
	elseif name == "red_lotus_gala_sxgame" then
		self._red_lotus_gala_sxgame = content
	elseif name == "red_lotus_gala_progress" then
		self._red_lotus_gala_progress = content
	elseif name == "red_lotus_gala_buy" then
		self._red_lotus_gala_buy = content
	elseif name == "red_lotus_gala_stage" then
		self._red_lotus_gala_stage = content
	elseif name == "red_lotus_gala_common" then
		self._red_lotus_gala_common = content
	end
end

function RedLotusDinnerPartyConfig:getCommonValue(key, isToNumber)
	if self._red_lotus_gala_common[key] then
		if isToNumber then
			return checknumber(self._red_lotus_gala_common[key].desc)
		else
			return self._red_lotus_gala_common[key].desc
		end
	end

	return ""
end

function RedLotusDinnerPartyConfig:getActivityCfgById(activityId)
	return self._red_lotus_gala_activity[activityId]
end

function RedLotusDinnerPartyConfig:getPerformPlanCfgList(performPlanId)
	return self._red_lotus_gala_perform[performPlanId]
end

function RedLotusDinnerPartyConfig:getPerformPlanCfg(performPlanId, gameId)
	if self._red_lotus_gala_perform[performPlanId] then
		return self._red_lotus_gala_perform[performPlanId][gameId]
	end
end

function RedLotusDinnerPartyConfig:getSxGameStageCfg(stageId)
	return self._red_lotus_gala_sxgame[stageId]
end

function RedLotusDinnerPartyConfig:getProgressCfgList(gamePrizePlan)
	return self._red_lotus_gala_progress[gamePrizePlan]
end

function RedLotusDinnerPartyConfig:getBuyCfgList(buyPlanId)
	return self._red_lotus_gala_buy[buyPlanId]
end

function RedLotusDinnerPartyConfig:getStageCfgList(stagePlanId)
	return self._red_lotus_gala_stage[stagePlanId]
end

function RedLotusDinnerPartyConfig:getStageCfg(stagePlanId, stageId)
	if self._red_lotus_gala_stage[stagePlanId] then
		return self._red_lotus_gala_stage[stagePlanId][stageId]
	end
end

function RedLotusDinnerPartyConfig:getPerformCfgById(performPlanId, gameId)
	if self._red_lotus_gala_perform[performPlanId] then
		return self._red_lotus_gala_perform[performPlanId][gameId]
	end
end

RedLotusDinnerPartyConfig.instance = RedLotusDinnerPartyConfig.New()

return RedLotusDinnerPartyConfig
