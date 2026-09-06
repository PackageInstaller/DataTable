-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/config/DragonXiuerConfig.lua

module("logic.extensions.dragonxiuer.config.DragonXiuerConfig", package.seeall)

local DragonXiuerConfig = class("DragonXiuerConfig", BaseConfig)

function DragonXiuerConfig:getNames()
	return {
		"dragon_xiuer_info",
		"dragon_xiuer_all_destroy_mode",
		"dragon_xiuer_soul_mode",
		"dragon_xiuer_challenge_team",
		"dragon_xiuer_challenge_creeps"
	}
end

function DragonXiuerConfig:handleConfig(name, content)
	if name == "dragon_xiuer_info" then
		self._dragon_xiuer_info = content
	elseif name == "dragon_xiuer_all_destroy_mode" then
		self._dragon_xiuer_all_destroy_mode = content
	elseif name == "dragon_xiuer_soul_mode" then
		self._dragon_xiuer_soul_mode = content
	elseif name == "dragon_xiuer_challenge_team" then
		self._dragon_xiuer_challenge_team = content
	elseif name == "dragon_xiuer_challenge_creeps" then
		self._dragon_xiuer_challenge_creeps = content
	end
end

function DragonXiuerConfig:getActCfg(actId)
	return self._dragon_xiuer_info[actId]
end

function DragonXiuerConfig:getActStageCfg(actId)
	return self._dragon_xiuer_all_destroy_mode[actId]
end

function DragonXiuerConfig:getBossCfg(actId)
	return self._dragon_xiuer_soul_mode[actId]
end

function DragonXiuerConfig:getTeamCfg(teamId)
	return self._dragon_xiuer_challenge_team[teamId]
end

function DragonXiuerConfig:getCreepsCfg(teamId)
	return self._dragon_xiuer_challenge_creeps[teamId]
end

function DragonXiuerConfig:getMaxStage(actId)
	return #(self._dragon_xiuer_all_destroy_mode[actId] or {})
end

DragonXiuerConfig.instance = DragonXiuerConfig.New()

return DragonXiuerConfig
