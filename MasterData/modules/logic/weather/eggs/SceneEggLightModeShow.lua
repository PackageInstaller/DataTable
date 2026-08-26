-- chunkname: @modules/logic/weather/eggs/SceneEggLightModeShow.lua

module("modules.logic.weather.eggs.SceneEggLightModeShow", package.seeall)

local SceneEggLightModeShow = class("SceneEggLightModeShow", SceneBaseEgg)

function SceneEggLightModeShow:_onInit()
	self._lightMode = tonumber(self._eggConfig.actionParams)

	self:setGoListVisible(false)
end

function SceneEggLightModeShow:_onReportChange(report)
	if not report then
		self:setGoListVisible(false)

		return
	end

	self:setGoListVisible(self._lightMode == report.lightMode)
end

return SceneEggLightModeShow
