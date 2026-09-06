-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/config/CiyuanshenglongConfig.lua

module("logic.extensions.ciyuanshenglong.config.CiyuanshenglongConfig", package.seeall)

local CiyuanshenglongConfig = class("CiyuanshenglongConfig", BaseConfig)

function CiyuanshenglongConfig:onInit()
	CiyuanshenglongConfig.super.onInit(self)
end

function CiyuanshenglongConfig:getNames()
	return {
		"ci_yuan_holy_dragon_clg_common",
		"ci_yuan_holy_dragon_clg_activity",
		"ci_yuan_holy_dragon_clg_stage",
		"ci_yuan_holy_dragon_clg_monster",
		"ci_yuan_holy_dragon_clg_creeps"
	}
end

function CiyuanshenglongConfig:handleConfig(name, content)
	if name == "ci_yuan_holy_dragon_clg_activity" then
		self._ci_yuan_holy_dragon_clg_activity = content
	elseif name == "ci_yuan_holy_dragon_clg_common" then
		self._ci_yuan_holy_dragon_clg_common = content
	elseif name == "ci_yuan_holy_dragon_clg_stage" then
		self._ci_yuan_holy_dragon_clg_stage = content
	elseif name == "ci_yuan_holy_dragon_clg_monster" then
		self._ci_yuan_holy_dragon_clg_monster = content
	elseif name == "ci_yuan_holy_dragon_clg_creeps" then
		self._ci_yuan_holy_dragon_clg_creeps = content
	end
end

function CiyuanshenglongConfig:getCommonValue(key, isToNumber)
	local str = ""

	if self._ci_yuan_holy_dragon_clg_common and self._ci_yuan_holy_dragon_clg_common[key] then
		str = self._ci_yuan_holy_dragon_clg_common[key].value
	end

	if isToNumber then
		str = checknumber(str)
	end

	return str
end

function CiyuanshenglongConfig:getActivityCfgById(id)
	return self._ci_yuan_holy_dragon_clg_activity[id]
end

function CiyuanshenglongConfig:getStageCfgListById(aid)
	local map = self._ci_yuan_holy_dragon_clg_stage[aid]
	local list = {}

	for k, v in pairs(map) do
		table.insert(list, v)
	end

	ArraySort.sortOn(list, "stageId", ArraySort.NUMERIC)

	return list
end

function CiyuanshenglongConfig:getStageCfgById(aid, stageId)
	if self._ci_yuan_holy_dragon_clg_stage[aid] then
		return self._ci_yuan_holy_dragon_clg_stage[aid][stageId]
	end
end

function CiyuanshenglongConfig:getMonsterCfgById(creepsMasterId)
	return self._ci_yuan_holy_dragon_clg_monster[creepsMasterId]
end

function CiyuanshenglongConfig:getCreepsCfg(creepsMasterId)
	return self._ci_yuan_holy_dragon_clg_creeps[creepsMasterId]
end

CiyuanshenglongConfig.instance = CiyuanshenglongConfig.New()

return CiyuanshenglongConfig
