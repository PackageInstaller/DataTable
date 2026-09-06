-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heatprogress/config/HeatProgressConfig.lua

module("logic.extensions.heatprogress.config.HeatProgressConfig", package.seeall)

local HeatProgressConfig = class("HeatProgressConfig", BaseConfig)

function HeatProgressConfig:onInit()
	HeatProgressConfig.super.onInit(self)
end

function HeatProgressConfig:getNames()
	return {
		"summary_progress",
		"summary_progress_prize"
	}
end

function HeatProgressConfig:handleConfig(name, content)
	if name == "summary_progress" then
		self._progressCfgs = content
	elseif name == "summary_progress_prize" then
		self._progressPrizeCfgs = content
	end
end

function HeatProgressConfig:getProgressCfgById(actId, id)
	local cfgs = self._progressCfgs[actId]

	if cfgs then
		return cfgs[id] or {}
	end

	return {}
end

function HeatProgressConfig:getProgressPrizeCfgsById(actId, id)
	local progressCfg = self:getProgressCfgById(actId, id)
	local prizePlanId = progressCfg.prizePlanId

	if not string.nilorempty(prizePlanId) then
		return self._progressPrizeCfgs[prizePlanId] or {}
	end

	return {}
end

HeatProgressConfig.instance = HeatProgressConfig.New()

return HeatProgressConfig
