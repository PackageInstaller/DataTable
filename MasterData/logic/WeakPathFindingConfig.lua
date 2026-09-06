-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/config/WeakPathFindingConfig.lua

module("logic.extensions.weakpathfinding.config.WeakPathFindingConfig", package.seeall)

local WeakPathFindingConfig = class("WeakPathFindingConfig", BaseConfig)

function WeakPathFindingConfig:onInit()
	WeakPathFindingConfig.super.onInit(self)
end

function WeakPathFindingConfig:getNames()
	return {
		"weak_path_finding",
		"weak_path_finding_prize",
		"weak_path_finding_game",
		"weak_path_finding_npc",
		"weak_path_finding_scene",
		"weak_path_finding_rule"
	}
end

function WeakPathFindingConfig:handleConfig(name, content)
	if name == "weak_path_finding" then
		self._actCfgs = content
	elseif name == "weak_path_finding_prize" then
		self._prizeCfgs = content
	elseif name == "weak_path_finding_scene" then
		self._sceneCfgs = content
	elseif name == "weak_path_finding_npc" then
		self._npcCfgs = content
	elseif name == "weak_path_finding_game" then
		self._gameCfgs = content
	elseif name == "weak_path_finding_rule" then
		self._ruleCfgs = content
	end
end

function WeakPathFindingConfig:getActCfgById(actId)
	return self._actCfgs[actId]
end

function WeakPathFindingConfig:getPrizeCfgsByPlanId(planId)
	return self._prizeCfgs[planId]
end

function WeakPathFindingConfig:getSceneCfg(actId, sceneId)
	local actCfg = self:getActCfgById(actId)

	if actCfg then
		return self._sceneCfgs[actCfg.scenePlanId][sceneId]
	end
end

function WeakPathFindingConfig:getNpcId(sceneId, Id)
	local npcCfgs = self._npcCfgs[sceneId]
	local cfg = npcCfgs and npcCfgs[Id]

	return (cfg or nil) and (cfg.npcId or 0)
end

function WeakPathFindingConfig:getNpcCfg(sceneId, Id)
	return self._npcCfgs[sceneId] and self._npcCfgs[sceneId][Id]
end

function WeakPathFindingConfig:getNpcCfgs()
	return self._npcCfgs.dataList
end

function WeakPathFindingConfig:getGameCfg(actId, gameId)
	local actCfg = self:getActCfgById(actId)

	if actCfg then
		return self._gameCfgs[actCfg.prizePlanId][gameId]
	end
end

function WeakPathFindingConfig:getRuleCfgs()
	return self._ruleCfgs
end

WeakPathFindingConfig.instance = WeakPathFindingConfig.New()

return WeakPathFindingConfig
