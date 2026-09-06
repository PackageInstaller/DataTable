-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/config/DivineGasiriConfig.lua

module("logic.extensions.divinegasiri.config.DivineGasiriConfig", package.seeall)

local DivineGasiriConfig = class("DivineGasiriConfig", BaseConfig)

function DivineGasiriConfig:onInit()
	DivineGasiriConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function DivineGasiriConfig:getNames()
	return {
		"divine_ares_mom_activity",
		"divine_ares_mom_stage",
		"divine_ares_mom_score",
		"divine_ares_mom_monster",
		"divine_ares_mom_creeps"
	}
end

function DivineGasiriConfig:handleConfig(name, content)
	if name == "divine_ares_mom_activity" then
		self._actCfgs = content
	elseif name == "divine_ares_mom_stage" then
		self._stageCfgs = content
	elseif name == "divine_ares_mom_score" then
		self._scoreCfgs = content
	elseif name == "divine_ares_mom_monster" then
		self._creepMasterCfgs = content
	elseif name == "divine_ares_mom_creeps" then
		self._creepCfgs = content
	end
end

function DivineGasiriConfig:getActCfg(actId)
	return self._actCfgs[actId]
end

function DivineGasiriConfig:getStageCfgs(actId)
	return self._stageCfgs[actId]
end

function DivineGasiriConfig:getMaxStage(actId)
	local stageCfgs = self:getStageCfgs(actId) or {}

	return table.nums(stageCfgs)
end

function DivineGasiriConfig:getStageCfg(actId, stageId)
	local stageCfgs = self:getStageCfgs(actId) or {}

	return stageCfgs[stageId]
end

function DivineGasiriConfig:getScoreCfg(actId, scoreType)
	return self._scoreCfgs[actId] and self._scoreCfgs[actId][scoreType]
end

function DivineGasiriConfig:getCreepMasterCfg(creepId)
	return self._creepMasterCfgs[creepId]
end

function DivineGasiriConfig:getCreepCfgs(creepId)
	return self._creepCfgs[creepId]
end

DivineGasiriConfig.instance = DivineGasiriConfig.New()

return DivineGasiriConfig
