-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/config/NeverLandConfig.lua

module("logic.extensions.neverland.config.NeverLandConfig", package.seeall)

local NeverLandConfig = class("NeverLandConfig", BaseConfig)

function NeverLandConfig:onInit()
	NeverLandConfig.super.onInit(self)
end

function NeverLandConfig:getNames()
	return {
		"never_land_activity",
		"never_land_support_pet",
		"never_land_master",
		"never_land_creeps",
		"never_land_buff",
		"never_land_rank_prize"
	}
end

function NeverLandConfig:handleConfig(name, content)
	if name == "never_land_activity" then
		self._neverLandActCfg = content
	elseif name == "never_land_support_pet" then
		self._neverLandPetCfg = content
	elseif name == "never_land_master" then
		self._neverLandMasterCfg = content
	elseif name == "never_land_creeps" then
		self._neverLandCreepsCfg = content
	elseif name == "never_land_buff" then
		self._neverLandBuffCfg = content
	elseif name == "never_land_rank_prize" then
		self._neverLandPrizCfg = content
	end
end

function NeverLandConfig:getActCfg(activityId)
	return self._neverLandActCfg[activityId]
end

function NeverLandConfig:getBuffCfg(activityId)
	return self._neverLandBuffCfg[activityId]
end

function NeverLandConfig:getBuffCfgById(activityId, buffId, level)
	return self._neverLandBuffCfg[activityId][buffId][level]
end

function NeverLandConfig:getMasterCfg(creepsMasterId)
	return self._neverLandMasterCfg[creepsMasterId]
end

function NeverLandConfig:getCreepsCfg(creepsMasterId)
	return self._neverLandCreepsCfg[creepsMasterId]
end

function NeverLandConfig:getSupportCfg(creepsId)
	return self._neverLandPetCfg[creepsId]
end

function NeverLandConfig:getRankCfg(activityId, mode, rank)
	local cfg = self._neverLandPrizCfg[activityId][mode]

	for _, v in pairs(cfg) do
		local min = v.rankRange[1]
		local max = v.rankRange[#v.rankRange]

		if min <= rank and rank <= max then
			return v.prize
		end
	end

	return cfg[#cfg].prize
end

NeverLandConfig.instance = NeverLandConfig.New()

return NeverLandConfig
