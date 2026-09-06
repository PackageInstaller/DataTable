-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/config/TianmanKingConfig.lua

module("logic.extensions.timelimitedchallenge.config.TianmanKingConfig", package.seeall)

local TianmanKingConfig = class("TianmanKingConfig", BaseConfig)

function TianmanKingConfig:onInit()
	TianmanKingConfig.super.onInit(self)
end

function TianmanKingConfig:getNames()
	return {
		"tian_man_wang_challenge_common",
		"tian_man_wang_challenge_type",
		"tian_man_wang_challenge_buff",
		"tian_man_wang_challenge_text",
		"tian_man_wang_challenge_buy_times",
		"tian_man_wang_challenge_progress_prize",
		"tian_man_wang_challenge_support_pet",
		"tian_man_wang_challenge_support_plan",
		"tian_man_wang_challenge_stage",
		"tian_man_wang_challenge_creeps"
	}
end

function TianmanKingConfig:handleConfig(name, content)
	if name == "tian_man_wang_challenge_common" then
		self._common = content
	elseif name == "tian_man_wang_challenge_type" then
		self._type = content
	elseif name == "tian_man_wang_challenge_buff" then
		self._buff = content
	elseif name == "tian_man_wang_challenge_buy_times" then
		self._buyTimes = content
	elseif name == "tian_man_wang_challenge_progress_prize" then
		self._progressPrize = content
	elseif name == "tian_man_wang_challenge_support_pet" then
		self._supportPet = content
	elseif name == "tian_man_wang_challenge_support_plan" then
		self._supportPlan = content
	elseif name == "tian_man_wang_challenge_stage" then
		self._stage = content
	elseif name == "tian_man_wang_challenge_creeps" then
		self._creeps = content
	elseif name == "tian_man_wang_challenge_text" then
		self._text = content
	end
end

function TianmanKingConfig:getCommonValueByKey(key)
	return self._common[key].value
end

function TianmanKingConfig:getTypeByType(challengeType)
	return self._type[challengeType]
end

function TianmanKingConfig:getType()
	return self._type
end

function TianmanKingConfig:getBuffByLevel(level)
	return self._buff[level]
end

function TianmanKingConfig:getBuff()
	return self._buff
end

function TianmanKingConfig:getBuyTimesByPlan(planId)
	return self._buyTimes[planId]
end

function TianmanKingConfig:getBuyTimes()
	return self._buyTimes
end

function TianmanKingConfig:getProgressPrizeById(id)
	return self._progressPrize[id]
end

function TianmanKingConfig:getProgressPrize()
	return self._progressPrize
end

function TianmanKingConfig:getSupportPetById(id)
	return self._supportPet[id]
end

function TianmanKingConfig:getSupportPet()
	return self._supportPet.dataList
end

function TianmanKingConfig:getSupportPlanById(id)
	return self._supportPlan[id]
end

function TianmanKingConfig:getSupportPlan()
	return self._supportPlan
end

function TianmanKingConfig:getStageByTypeAndStage(challengeType, stage)
	return self._stage[challengeType][stage]
end

function TianmanKingConfig:getStage()
	return self._stage
end

function TianmanKingConfig:getStageByType(challengeType)
	return self._stage[challengeType]
end

function TianmanKingConfig:getCreepByMasterId(masterId)
	return self._creeps[masterId]
end

function TianmanKingConfig:getCreep()
	return self._creeps
end

function TianmanKingConfig:getTextByKey(key)
	return self._text[key].value
end

TianmanKingConfig.instance = TianmanKingConfig.New()

return TianmanKingConfig
