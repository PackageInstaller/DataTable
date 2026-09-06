-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonkingaruishiclg/config/DragonKingARuiShiClgConfig.lua

module("logic.extensions.dragonkingaruishiclg.config.DragonKingARuiShiClgConfig", package.seeall)

local DragonKingARuiShiClgConfig = class("DragonKingARuiShiClgConfig", BaseConfig)

function DragonKingARuiShiClgConfig:onInit()
	DragonKingARuiShiClgConfig.super.onInit(self)
end

function DragonKingARuiShiClgConfig:getNames()
	return {
		"dragon_king_aruishi_challenge_activity",
		"dragon_king_aruishi_challenge_stage",
		"dragon_king_aruishi_challenge_team",
		"dragon_king_aruishi_challenge_creeps"
	}
end

function DragonKingARuiShiClgConfig:handleConfig(name, content)
	if name == "dragon_king_aruishi_challenge_activity" then
		self._dragon_king_aruishi_challenge_activity = content
	elseif name == "dragon_king_aruishi_challenge_stage" then
		self._dragon_king_aruishi_challenge_stage = content
	elseif name == "dragon_king_aruishi_challenge_team" then
		self._dragon_king_aruishi_challenge_team = content
	elseif name == "dragon_king_aruishi_challenge_creeps" then
		self._dragon_king_aruishi_challenge_creeps = content
	end
end

function DragonKingARuiShiClgConfig:getActivityCfg(activityId)
	return self._dragon_king_aruishi_challenge_activity[activityId]
end

function DragonKingARuiShiClgConfig:getStageCfgs(activityId)
	return self._dragon_king_aruishi_challenge_stage[activityId]
end

function DragonKingARuiShiClgConfig:getStageCfg(activityId, stageId)
	return self._dragon_king_aruishi_challenge_stage[activityId][stageId]
end

function DragonKingARuiShiClgConfig:getTeamCfg(creepsMasterId)
	return self._dragon_king_aruishi_challenge_team[creepsMasterId]
end

function DragonKingARuiShiClgConfig:getCreepCfg(creepsMasterId)
	return self._dragon_king_aruishi_challenge_creeps[creepsMasterId]
end

function DragonKingARuiShiClgConfig:getDamage(creepsMasterId)
	local temaCfg = self._dragon_king_aruishi_challenge_team[creepsMasterId]
	local winCfg = BattleSettlementConfig.instance:getBattleWinnerOpCfgById(temaCfg.winId)

	return checknumber(winCfg.params)
end

DragonKingARuiShiClgConfig.instance = DragonKingARuiShiClgConfig.New()

return DragonKingARuiShiClgConfig
