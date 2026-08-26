-- chunkname: @modules/logic/weather/controller/behaviour/WeatherBehaviourContainer.lua

module("modules.logic.weather.controller.behaviour.WeatherBehaviourContainer", package.seeall)

local WeatherBehaviourContainer = class("WeatherBehaviourContainer", BaseUnitSpawn)

function WeatherBehaviourContainer.Create(containerGO)
	return MonoHelper.addNoUpdateLuaComOnceToGo(containerGO, WeatherBehaviourContainer)
end

function WeatherBehaviourContainer:setSceneId(sceneId)
	self._sceneId = sceneId
	self._sceneConfig = lua_scene_switch.configDict[self._sceneId]

	if MainSceneSwitchEnum.SpSceneMap[self._sceneId] then
		self:addComp("dayNightChange", WeatherDayNightChange)
		self.dayNightChange:setSceneConfig(self._sceneConfig)
	end
end

function WeatherBehaviourContainer:setLightMats(lightMats)
	if MainSceneSwitchEnum.SpSceneMap[self._sceneId] then
		self.dayNightChange:setLightMats(lightMats)
	end
end

function WeatherBehaviourContainer:initComponents()
	return
end

function WeatherBehaviourContainer:setReport(prevReport, curReport)
	self._prevReport = prevReport
	self._curReport = curReport

	local compList = self:getCompList()

	for i, comp in ipairs(compList) do
		comp:setReport(prevReport, curReport)
	end
end

function WeatherBehaviourContainer:changeBlendValue(value, isEnd, revert)
	if self.dayNightChange then
		self.dayNightChange:changeBlendValue(value, isEnd, revert)
	end
end

return WeatherBehaviourContainer
