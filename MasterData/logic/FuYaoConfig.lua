-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/config/FuYaoConfig.lua

module("logic.extensions.fuyao.config.FuYaoConfig", package.seeall)

local FuYaoConfig = class("FuYaoConfig", BaseConfig)

function FuYaoConfig:onInit()
	FuYaoConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function FuYaoConfig:getNames()
	return {
		"fuyao_challenge",
		"fuyao_challenge_common",
		"fuyao_challenge_extreme",
		"fuyao_challenge_master",
		"fuyao_challenge_creeps"
	}
end

function FuYaoConfig:handleConfig(name, content)
	if name == "fuyao_challenge" then
		self._fuyaoChallengeCfg = content
	elseif name == "fuyao_challenge_common" then
		self._fuyaoCommonCfg = content
	elseif name == "fuyao_challenge_extreme" then
		self._fuyaoExtremeCfg = content
	elseif name == "fuyao_challenge_master" then
		self._fuyaoMasterCfg = content
	elseif name == "fuyao_challenge_creeps" then
		self._fuyaoCreepsCfg = content
	end
end

function FuYaoConfig:getFuyaoChallengeCfg(actId)
	return self._fuyaoChallengeCfg[actId]
end

function FuYaoConfig:getFuyaoCommonCfg(actId)
	return self._fuyaoCommonCfg[actId]
end

function FuYaoConfig:getFuyaoCommonCfgById(actId, puzzleId)
	return self._fuyaoCommonCfg[actId][puzzleId]
end

function FuYaoConfig:getFuyaoExtremeCfg(actId)
	return self._fuyaoExtremeCfg[actId]
end

function FuYaoConfig:getFuyaoMasterCfg(actId, stageId)
	return self._fuyaoExtremeCfg[actId][stageId]
end

function FuYaoConfig:getFuyaoMasterCfg(creepsMasterId)
	return self._fuyaoMasterCfg[creepsMasterId]
end

function FuYaoConfig:getFuyaoCreepCfg(creepsMasterId)
	return self._fuyaoCreepsCfg[creepsMasterId]
end

FuYaoConfig.instance = FuYaoConfig.New()

return FuYaoConfig
