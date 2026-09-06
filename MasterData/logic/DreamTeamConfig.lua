-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/config/DreamTeamConfig.lua

module("logic.extensions.dreamteam.config.DreamTeamConfig", package.seeall)

local DreamTeamConfig = class("DreamTeamConfig", BaseConfig)

function DreamTeamConfig:onInit()
	DreamTeamConfig.super.onInit(self)

	self._flipTouchActivityCfg = nil
	self._flipTouchOutPrizeCfg = nil
	self._flipTouchInteractionCfg = nil
	self._flipTouchGlobalPrizeCfg = nil
end

function DreamTeamConfig:getNames()
	return {
		"flip_touch_activity",
		"flip_touch_out_prize",
		"flip_touch_interaction",
		"flip_touch_global_prize"
	}
end

function DreamTeamConfig:handleConfig(name, content)
	if name == "flip_touch_activity" then
		self._flipTouchActivityCfg = content
	elseif name == "flip_touch_out_prize" then
		self._flipTouchOutPrizeCfg = content
	elseif name == "flip_touch_interaction" then
		self._flipTouchInteractionCfg = content
	elseif name == "flip_touch_global_prize" then
		self._flipTouchGlobalPrizeCfg = content
	end
end

function DreamTeamConfig:getActivityCfgById(id)
	return self._flipTouchActivityCfg[id]
end

function DreamTeamConfig:getOutPrizeCfg(planId, id)
	if self._flipTouchOutPrizeCfg[planId] then
		return self._flipTouchOutPrizeCfg[planId][id]
	end

	return nil
end

function DreamTeamConfig:getInteractionCfg(planId, stageId)
	if self._flipTouchInteractionCfg[planId] then
		return self._flipTouchInteractionCfg[planId][stageId]
	end
end

function DreamTeamConfig:getOutPrizeCfgs(planId)
	return self._flipTouchOutPrizeCfg[planId]
end

function DreamTeamConfig:getInteractionCfgs(planId)
	return self._flipTouchInteractionCfg[planId]
end

function DreamTeamConfig:getGlobalPrizeCfgs(planId)
	return self._flipTouchGlobalPrizeCfg[planId] or {}
end

DreamTeamConfig.instance = DreamTeamConfig.New()

return DreamTeamConfig
