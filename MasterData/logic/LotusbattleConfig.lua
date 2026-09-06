-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/config/LotusbattleConfig.lua

module("logic.extensions.lotusbattle.config.LotusbattleConfig", package.seeall)

local LotusbattleConfig = class("LotusbattleConfig", BaseConfig)

function LotusbattleConfig:onInit()
	return
end

function LotusbattleConfig:getNames()
	return {
		"lotus_battle_field_activity",
		"lotus_battle_field_model",
		"lotus_battle_field_time",
		"lotus_battle_field_match",
		"lotus_battle_field_pet_pool",
		"lotus_battle_field_creeps",
		"lotus_battle_field_buff",
		"lotus_battle_field_win_buff",
		"lotus_battle_field_rank",
		"lotus_battle_field_kill",
		"lotus_battle_field_common"
	}
end

function LotusbattleConfig:handleConfig(name, content)
	if name == "lotus_battle_field_activity" then
		self._lotus_battle_field_activity = content
	elseif name == "lotus_battle_field_model" then
		self._lotus_battle_field_model = content
	elseif name == "lotus_battle_field_time" then
		self._lotus_battle_field_time = content
	elseif name == "lotus_battle_field_match" then
		self._lotus_battle_field_match = content
	elseif name == "lotus_battle_field_pet_pool" then
		self._lotus_battle_field_pet_pool = content
	elseif name == "lotus_battle_field_creeps" then
		self._lotus_battle_field_creeps = content
	elseif name == "lotus_battle_field_buff" then
		self._lotus_battle_field_buff = content
	elseif name == "lotus_battle_field_win_buff" then
		self._lotus_battle_field_win_buff = content
	elseif name == "lotus_battle_field_rank" then
		self._lotus_battle_field_rank = content
	elseif name == "lotus_battle_field_kill" then
		self._lotus_battle_field_kill = content
	elseif name == "lotus_battle_field_common" then
		self._lotus_battle_field_common = content
	end
end

function LotusbattleConfig:getModelCfgs(activityId)
	return self._lotus_battle_field_model[activityId]
end

function LotusbattleConfig:getModelCfg(activityId, modelId)
	return self._lotus_battle_field_model[activityId][modelId]
end

function LotusbattleConfig:getModelDailyTimes(activityId, modelId)
	return self._lotus_battle_field_model[activityId][modelId].dailyTimes
end

function LotusbattleConfig:getPetPoolCfgs(petPoolId)
	return self._lotus_battle_field_pet_pool[petPoolId]
end

function LotusbattleConfig:getPetPoolCfg(petPoolId, id)
	return self._lotus_battle_field_pet_pool[petPoolId][id]
end

function LotusbattleConfig:getCreepsCfgsByPoolId(petPoolId, id)
	local cfg = self:getPetPoolCfg(petPoolId, id)
	local creepCfgs = {}

	for i, creepId in ipairs(cfg.creepIds) do
		table.insert(creepCfgs, self:getCreepsCfg(creepId))
	end

	return creepCfgs
end

function LotusbattleConfig:getCreepsCfg(creepsId)
	return self._lotus_battle_field_creeps[creepsId]
end

function LotusbattleConfig:getStageTime(activityId, key)
	return self._lotus_battle_field_time[activityId][key]
end

function LotusbattleConfig:getInitPetMaxNum(activityId)
	return self._lotus_battle_field_activity[activityId].petNum
end

function LotusbattleConfig:getBuffCfg(buffPlanId, buffId)
	return self._lotus_battle_field_buff[buffPlanId][buffId]
end

function LotusbattleConfig:getBuffCfgByParams(activityId, modelId, buffId)
	local modelCfg = self:getModelCfg(activityId, modelId)

	return self:getBuffCfg(modelCfg.buffPlanId, buffId)
end

function LotusbattleConfig:getActCfg(activityId)
	return self._lotus_battle_field_activity[activityId]
end

function LotusbattleConfig:getCommonValue(key, need2number)
	local value = ""

	if self._lotus_battle_field_common[key].value then
		value = not string.nilorempty(self._lotus_battle_field_common[key].value2) and self._lotus_battle_field_common[key].value2 or self._lotus_battle_field_common[key].value
	end

	if need2number then
		return checknumber(value)
	end

	return value
end

function LotusbattleConfig:getBuffTipSimpleData(buffPlanId, buffId)
	self._buffSimpleDatas = self._buffSimpleDatas or {}

	local key = buffPlanId .. "@" .. buffId
	local data = self._buffSimpleDatas[key]

	if not data then
		local cfg = self:getBuffCfg(buffPlanId, buffId)

		data = {
			buffName = cfg.name,
			buffDesc = cfg.buffDesc,
			iconPath = GameUrl.getExpEventUrl(cfg.iconPath)
		}
		self._buffSimpleDatas[key] = data
	end

	return data
end

function LotusbattleConfig:getSpoilsNumByRank(activityId, modelId, rank)
	local modelCfg = self:getModelCfg(activityId, modelId)

	for i, v in ipairs(self._lotus_battle_field_rank.dataList) do
		if v.rankPlanId == modelCfg.rankPlanId and rank >= v.startRank and rank <= v.endRank then
			return v.spoilsNum
		end
	end
end

function LotusbattleConfig:getRankTitleImgNameByRank(rankPlanId, rank)
	for i, v in ipairs(self._lotus_battle_field_rank.dataList) do
		if v.rankPlanId == rankPlanId and rank >= v.startRank and rank <= v.endRank then
			return v.rankTitle
		end
	end
end

function LotusbattleConfig:getWinBuffCfg(winBuffPlanId, winTimes)
	return self._lotus_battle_field_win_buff[winBuffPlanId][winTimes]
end

LotusbattleConfig.instance = LotusbattleConfig.New()

return LotusbattleConfig
