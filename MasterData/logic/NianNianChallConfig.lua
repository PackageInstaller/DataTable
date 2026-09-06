-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/config/NianNianChallConfig.lua

module("logic.extensions.niannianchall.config.NianNianChallConfig", package.seeall)

local NianNianChallConfig = class("NianNianChallConfig", BaseConfig)

function NianNianChallConfig:onInit()
	NianNianChallConfig.super.onInit(self)

	self._paramCfg = nil
	self._actCfg = nil
	self._gameCfg = nil
	self._buyCfg = nil
	self._terrCfg = nil
	self._monsterCfg = nil
	self._propCfg = nil
end

function NianNianChallConfig:getNames()
	return {
		"nian_challenge_common",
		"nian_challenge_stage",
		"nian_challenge_support_creeps",
		"nian_challenge_team",
		"nian_challenge_creeps",
		"nian_challenge_progress_prize",
		"nian_challenge_buff"
	}
end

function NianNianChallConfig:handleConfig(name, content)
	if name == "nian_challenge_common" then
		self._commonCfg = content
	elseif name == "nian_challenge_stage" then
		self._stageCfg = content
	elseif name == "nian_challenge_support_creeps" then
		self._supportCfg = content
	elseif name == "nian_challenge_team" then
		self._teamCfg = content
	elseif name == "nian_challenge_creeps" then
		self._creepCfg = content
	elseif name == "nian_challenge_progress_prize" then
		self._prizeCfg = content
	elseif name == "nian_challenge_buff" then
		self._buffCfg = content
	end
end

function NianNianChallConfig:getCreepsCfg(id)
	return self._creepCfg[id]
end

function NianNianChallConfig:getStageCfg(id)
	return self._stageCfg[id]
end

function NianNianChallConfig:getStageCfgList()
	return self._stageCfg.dataList
end

function NianNianChallConfig:getSupportCfg(id)
	return self._supportCfg[id]
end

function NianNianChallConfig:getCommonCfg(key)
	return self._commonCfg[key].value
end

function NianNianChallConfig:getPrizeCfg()
	return self._prizeCfg
end

function NianNianChallConfig:getBuffCfg(level)
	return self._buffCfg[level]
end

function NianNianChallConfig:getLevelCfg2(id, level)
	return self._levelCfg[id][level]
end

function NianNianChallConfig:getDefineCfg(id)
	return self._defineCfg[id]
end

function NianNianChallConfig:getProgramCfg(id, level)
	return self._programCfg[id][level]
end

NianNianChallConfig.instance = NianNianChallConfig.New()

return NianNianChallConfig
