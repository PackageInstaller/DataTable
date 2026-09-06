-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/config/PeakDiamondConfig.lua

module("logic.extensions.bonus.config.PeakDiamondConfig", package.seeall)

local PeakDiamondConfig = class("PeakDiamondConfig", BaseConfig)

function PeakDiamondConfig:onInit()
	PeakDiamondConfig.super.onInit(self)

	self._pdBaseCfgs = nil
end

function PeakDiamondConfig:getNames()
	return {
		"peak_return"
	}
end

function PeakDiamondConfig:handleConfig(name, content)
	if name == "peak_return" then
		self._pdBaseCfgs = content
	end
end

function PeakDiamondConfig:getPeakDiamondActivityId()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.PeakDiamond)

	if cfg == nil then
		return -1
	end

	return cfg.activityId
end

function PeakDiamondConfig:getPeakDiamondActivityCfg(actId)
	if self._pdBaseCfgs == nil or self._pdBaseCfgs[actId] == nil then
		return
	end

	return self._pdBaseCfgs[actId]
end

PeakDiamondConfig.instance = PeakDiamondConfig.New()

return PeakDiamondConfig
