-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/config/FbbchallengeConfig.lua

module("logic.extensions.fbbchallenge.config.FbbchallengeConfig", package.seeall)

local FbbchallengeConfig = class("FbbchallengeConfig", BaseConfig)

function FbbchallengeConfig:onInit()
	return
end

function FbbchallengeConfig:getNames()
	return {
		"fengbaobao_challenge_params_define",
		"fengbaobao_challenge_monster",
		"fengbaobao_challenge_creeps",
		"fengbaobao_challenge_support_pet",
		"fengbaobao_challenge_buy_times",
		"fengbaobao_challenge_buff",
		"fengbaobao_challenge_acc_harm_prize",
		"fengbaobao_challenge_game_plan",
		"fengbaobao_challenge_game_slot",
		"fengbaobao_challenge_game_tamplate",
		"fengbaobao_challenge_pet_tamplate"
	}
end

function FbbchallengeConfig:handleConfig(name, content)
	if name == "fengbaobao_challenge_params_define" then
		self._fengbaobao_challenge_params_define = content
	elseif name == "fengbaobao_challenge_game_plan" then
		self._fengbaobao_challenge_game_plan = content
	elseif name == "fengbaobao_challenge_game_slot" then
		self._fengbaobao_challenge_game_slot = content
	elseif name == "fengbaobao_challenge_game_tamplate" then
		self._fengbaobao_challenge_game_tamplate = content
	elseif name == "fengbaobao_challenge_monster" then
		self._fengbaobao_challenge_monster = content
	elseif name == "fengbaobao_challenge_creeps" then
		self._fengbaobao_challenge_creeps = content
	elseif name == "fengbaobao_challenge_support_pet" then
		self._fengbaobao_challenge_support_pet = content
	elseif name == "fengbaobao_challenge_buy_times" then
		self._fengbaobao_challenge_buy_times = content
	elseif name == "fengbaobao_challenge_buff" then
		self._fengbaobao_challenge_buff = content
	elseif name == "fengbaobao_challenge_acc_harm_prize" then
		self._fengbaobao_challenge_acc_harm_prize = content
	elseif name == "fengbaobao_challenge_pet_tamplate" then
		self._fengbaobao_challenge_pet_tamplate = content
	end
end

function FbbchallengeConfig:getGamePlanId()
	return checknumber(self:getDefineValue("GAME_PLAN_ID"))
end

function FbbchallengeConfig:getDefineValue(key, need2number)
	if need2number then
		return checknumber(self._fengbaobao_challenge_params_define[key].value)
	else
		return self._fengbaobao_challenge_params_define[key].value
	end
end

function FbbchallengeConfig:getGamePlanCfgs(planId)
	return self._fengbaobao_challenge_game_plan[planId]
end

function FbbchallengeConfig:getGameTemplateCfgs(templateId)
	return self._fengbaobao_challenge_game_tamplate[templateId]
end

function FbbchallengeConfig:getGameSlotCfg(slotId)
	return self._fengbaobao_challenge_game_slot[slotId]
end

function FbbchallengeConfig:getMonsterCfg(creepsMasterId)
	return self._fengbaobao_challenge_monster[creepsMasterId]
end

function FbbchallengeConfig:getSupportCfg(supportPlanId)
	return self._fengbaobao_challenge_support_pet[supportPlanId]
end

function FbbchallengeConfig:getCreepsCfg(creepsMasterId)
	return self._fengbaobao_challenge_creeps[creepsMasterId]
end

function FbbchallengeConfig:getBuffPlanCfgs(planId)
	return self._fengbaobao_challenge_buff[planId]
end

function FbbchallengeConfig:getRewardPlanCfgs(planId)
	return self._fengbaobao_challenge_acc_harm_prize[planId]
end

function FbbchallengeConfig:getPetTemplateCfgs(stageId)
	return self._fengbaobao_challenge_pet_tamplate[stageId]
end

function FbbchallengeConfig:getBuyTimeCfgs(planId)
	return self._fengbaobao_challenge_buy_times[planId]
end

FbbchallengeConfig.instance = FbbchallengeConfig.New()

return FbbchallengeConfig
