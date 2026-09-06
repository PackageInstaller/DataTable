-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/config/ChuangkongunionConfig.lua

module("logic.extensions.chuangkongunion.config.ChuangkongunionConfig", package.seeall)

local ChuangkongunionConfig = class("ChuangkongunionConfig", BaseConfig)

function ChuangkongunionConfig:onInit()
	return
end

function ChuangkongunionConfig:getNames()
	return {
		"chuang_kong_union_activity",
		"chuang_kong_union_breach_form",
		"chuang_kong_union_daily_task",
		"chuang_kong_union_breach_form_stage",
		"chuang_kong_union_breach_form_pet",
		"chuang_kong_union_team",
		"chuang_kong_union_creeps",
		"chuang_kong_union_common",
		"chuang_kong_union_tabview",
		"chuang_kong_union_question"
	}
end

function ChuangkongunionConfig:handleConfig(name, content)
	if name == "chuang_kong_union_activity" then
		self._actCfg = content
	elseif name == "chuang_kong_union_breach_form" then
		self._breachForm = content
	elseif name == "chuang_kong_union_breach_form_stage" then
		self._breachFormStage = content
	elseif name == "chuang_kong_union_breach_form_pet" then
		self._breachFormPet = content
	elseif name == "chuang_kong_union_team" then
		self._team = content
	elseif name == "chuang_kong_union_creeps" then
		self._creeps = content
	elseif name == "chuang_kong_union_common" then
		self._common = content
	elseif name == "chuang_kong_union_tabview" then
		self._tabCfg = content
	elseif name == "chuang_kong_union_daily_task" then
		self._taskCfg = content
	elseif name == "chuang_kong_union_question" then
		self._questionCfgs = content
	end
end

function ChuangkongunionConfig:getBreachFormStageById(id)
	return self._breachFormStage[id]
end

function ChuangkongunionConfig:getBreachFormPetById(id)
	return self._breachFormPet[id]
end

function ChuangkongunionConfig:getTeamById(id)
	return self._team[id]
end

function ChuangkongunionConfig:getCreepsById(id)
	return self._creeps[id]
end

function ChuangkongunionConfig:getCommonValue(key)
	if key == "GOODS_NAME" then
		return lang("特惠星神")
	end

	if self._common[key] then
		return self._common[key].value
	end

	return ""
end

function ChuangkongunionConfig:getTabCfg()
	return self._tabCfg
end

function ChuangkongunionConfig:getCfg(actId)
	return self._actCfg[actId]
end

function ChuangkongunionConfig:getCoinItemStr(actId)
	return self:getCfg(actId).scoreItemKey
end

function ChuangkongunionConfig:getBreachFormCfg(actId)
	return self._breachForm[self:getBreachFormPlan(actId)]
end

function ChuangkongunionConfig:getTaskCfg(actId)
	return self._taskCfg[self:getDailyTaskPlan(actId)]
end

function ChuangkongunionConfig:getBreachFormPlan(actId)
	return self:getCfg(actId).breachFormPlan
end

function ChuangkongunionConfig:getDailyTaskPlan(actId)
	return self:getCfg(actId).dailyTaskPlan
end

function ChuangkongunionConfig:getQuestionCfg(questionId)
	return self._questionCfgs[questionId]
end

ChuangkongunionConfig.instance = ChuangkongunionConfig.New()

return ChuangkongunionConfig
