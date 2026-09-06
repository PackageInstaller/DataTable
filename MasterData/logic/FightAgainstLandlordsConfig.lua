-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/config/FightAgainstLandlordsConfig.lua

module("logic.extensions.landlords.config.FightAgainstLandlordsConfig", package.seeall)

local FightAgainstLandlordsConfig = class("FightAgainstLandlordsConfig", BaseConfig)

function FightAgainstLandlordsConfig:onInit()
	FightAgainstLandlordsConfig.super.onInit(self)
end

function FightAgainstLandlordsConfig:getNames()
	return {
		"fight_against_landlords_base",
		"fight_against_landlords_common",
		"fight_against_landlords_game",
		"fight_against_landlords_creeps",
		"fight_against_landlords_buff",
		"fight_against_landlords_cp",
		"fight_against_landlords_chat",
		"fight_against_landlords_rank_prize"
	}
end

function FightAgainstLandlordsConfig:handleConfig(name, content)
	if name == "fight_against_landlords_base" then
		self._falBaseCfg = content
	elseif name == "fight_against_landlords_common" then
		self._falCommonCfg = content
	elseif name == "fight_against_landlords_game" then
		self._falGameCfgs = content
	elseif name == "fight_against_landlords_creeps" then
		self._falCreepsCfg = content
	elseif name == "fight_against_landlords_buff" then
		self._falBuffCfgs = content
	elseif name == "fight_against_landlords_cp" then
		self._falCpCfgs = content
	elseif name == "fight_against_landlords_chat" then
		self._falChatCfg = content
	elseif name == "fight_against_landlords_rank_prize" then
		self._fight_against_landlords_rank_prize = content
	end
end

function FightAgainstLandlordsConfig:getFalBaseData(activityId)
	return self._falBaseCfg[activityId]
end

function FightAgainstLandlordsConfig:getFalCommonValue(key)
	if self._falCommonCfg[key] then
		if not string.nilorempty(self._falCommonCfg[key].value2) then
			return self._falCommonCfg[key].value2
		else
			return self._falCommonCfg[key].value
		end
	end
end

function FightAgainstLandlordsConfig:getFalGameCfg(activityId)
	local baseData = self:getFalBaseData(activityId)

	return self._falGameCfgs[baseData.gamePlanId]
end

function FightAgainstLandlordsConfig:getFalGameData(activityId, gameId)
	return self:getFalGameCfg(activityId)[gameId]
end

function FightAgainstLandlordsConfig:getFalCreepsCfg()
	return self._falCreepsCfg
end

function FightAgainstLandlordsConfig:getFalCreepsData(creepsId)
	return self._falCreepsCfg[creepsId]
end

function FightAgainstLandlordsConfig:getFalBuffData(activityId, buffId)
	local baseData = self:getFalBaseData(activityId)

	return self._falBuffCfgs[baseData.buffPlanId][buffId]
end

function FightAgainstLandlordsConfig:getFalCpCfg(activityId)
	local baseData = self:getFalBaseData(activityId)

	return self._falCpCfgs[baseData.cpPlanId]
end

function FightAgainstLandlordsConfig:getFalCpData(activityId, cpId)
	return self:getFalCpCfg(activityId)[cpId]
end

function FightAgainstLandlordsConfig:getFalChatCfg()
	return self._falChatCfg
end

function FightAgainstLandlordsConfig:getFalChatData(chatId)
	return self._falChatCfg[chatId]
end

function FightAgainstLandlordsConfig:getPrizeCfg(activityId, rank)
	for k, v in pairs(self._fight_against_landlords_rank_prize[activityId]) do
		if rank >= k[1] and rank <= k[2] then
			return v
		end
	end
end

FightAgainstLandlordsConfig.instance = FightAgainstLandlordsConfig.New()

return FightAgainstLandlordsConfig
