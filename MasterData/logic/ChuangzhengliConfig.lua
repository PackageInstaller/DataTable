-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangzhengli/config/ChuangzhengliConfig.lua

module("logic.extensions.chuangzhengli.config.ChuangzhengliConfig", package.seeall)

local ChuangzhengliConfig = class("ChuangzhengliConfig", BaseConfig)

function ChuangzhengliConfig:onInit()
	return
end

function ChuangzhengliConfig:getNames()
	return {
		"chuang_zhengli_clg_creeps",
		"chuang_zhengli_clg_stage",
		"chuang_zhengli_clg_monster",
		"chuang_zhengli_clg_activity"
	}
end

function ChuangzhengliConfig:handleConfig(name, content)
	if name == "chuang_zhengli_clg_creeps" then
		self._chuang_zhengli_clg_creeps = content
	elseif name == "chuang_zhengli_clg_stage" then
		self._chuang_zhengli_clg_stage = content
	elseif name == "chuang_zhengli_clg_monster" then
		self._chuang_zhengli_clg_monster = content
	elseif name == "chuang_zhengli_clg_activity" then
		self._chuang_zhengli_clg_activity = content
	end
end

function ChuangzhengliConfig:getActCfg(activityId)
	return self._chuang_zhengli_clg_activity[activityId]
end

function ChuangzhengliConfig:getSkinId(activityId)
	return self._chuang_zhengli_clg_activity[activityId].skinId
end

function ChuangzhengliConfig:getStageCfgs(activityId)
	return self._chuang_zhengli_clg_stage[activityId]
end

function ChuangzhengliConfig:getStageCfg(activityId, stageId)
	return self._chuang_zhengli_clg_stage[activityId][stageId]
end

function ChuangzhengliConfig:getCreepsMasterCfgs(activityId, stageId)
	local stageCfg = self:getStageCfg(activityId, stageId)
	local creepsCfgs = {}

	for i, creepsMasterId in ipairs(stageCfg.teams) do
		table.insert(creepsCfgs, self:getMasterCfg(creepsMasterId))
	end

	return creepsCfgs
end

function ChuangzhengliConfig:getCreepsMasterCfg(creepsMasterId)
	return self._chuang_zhengli_clg_monster[creepsMasterId]
end

function ChuangzhengliConfig:getMasterCfg(creepsMasterId)
	return self._chuang_zhengli_clg_monster[creepsMasterId]
end

function ChuangzhengliConfig:getCreepsCfgs(creepsMasterId)
	return self._chuang_zhengli_clg_creeps[creepsMasterId]
end

ChuangzhengliConfig.instance = ChuangzhengliConfig.New()

return ChuangzhengliConfig
