-- chunkname: @modules/logic/weather/eggs/SceneEggLightModeAnimShow.lua

module("modules.logic.weather.eggs.SceneEggLightModeAnimShow", package.seeall)

local SceneEggLightModeAnimShow = class("SceneEggLightModeAnimShow", SceneBaseEgg)

function SceneEggLightModeAnimShow:_onInit()
	self._animNameList = string.split(self._eggConfig.actionParams, "#")

	self:setGoListVisible(false)
end

function SceneEggLightModeAnimShow:_onEnable()
	if not self._lightMode then
		return
	end

	local animName = self._animNameList[self._lightMode]

	if not animName then
		return
	end

	self:playAnim(animName)
end

function SceneEggLightModeAnimShow:_onDisable()
	self:setGoListVisible(false)
end

function SceneEggLightModeAnimShow:_onReportChange(report)
	if not report then
		return
	end

	self._lightMode = report.lightMode
end

return SceneEggLightModeAnimShow
