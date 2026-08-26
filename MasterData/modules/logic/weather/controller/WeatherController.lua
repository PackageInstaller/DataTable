-- chunkname: @modules/logic/weather/controller/WeatherController.lua

module("modules.logic.weather.controller.WeatherController", package.seeall)

local WeatherController = class("WeatherController", BaseController)

function WeatherController:onInit()
	return
end

function WeatherController:onInitFinish()
	self._weatherComp = WeatherComp.New(self, true)

	self._weatherComp:onInit()
	self.registerCallback(self, WeatherEvent.OnRoleBlend, self._onWeatherOnRoleBlend, self)
end

function WeatherController:resetWeatherChangeVoiceFlag()
	self._weatherComp:resetWeatherChangeVoiceFlag()
end

function WeatherController:setLightModel(lightModel)
	self._weatherComp:setLightModel(lightModel)
end

function WeatherController:initRoleGo(roleGo, heroId, sharedMaterial, playVoice, skinId)
	self._weatherComp:initRoleGo(roleGo, heroId, sharedMaterial, playVoice, skinId)
end

function WeatherController:changeRoleGo(param)
	self._weatherComp:changeRoleGo(param)
end

function WeatherController:clearMat()
	self._weatherComp:clearMat()
end

function WeatherController:setRoleMaskEnabled(value)
	self._weatherComp:setRoleMaskEnabled(value)
end

function WeatherController:getSceneNode(nodePath)
	return self._weatherComp:getSceneNode(nodePath)
end

function WeatherController:playAnim(name)
	self._weatherComp:playAnim(name)
end

function WeatherController:initSceneGo(sceneGo, callback, callbackTarget)
	local sceneId = MainSceneSwitchModel.instance:getCurSceneId()

	self._weatherComp:setSceneId(sceneId)
	self._weatherComp:initSceneGo(sceneGo, callback, callbackTarget)
end

function WeatherController:updateOtherComps(sceneGo)
	local sceneId = MainSceneSwitchModel.instance:getCurSceneId()

	if self._eggContainer then
		self._eggContainer:onSceneClose()

		self._eggContainer = nil
	end

	self._eggContainer = WeatherEggContainerComp.New()

	self._eggContainer:onInit(sceneId, true)
	self._eggContainer:initSceneGo(sceneGo)
	self._weatherComp:addChangeReportCallback(self._eggContainer.onReportChange, self._eggContainer, true)

	if self._weatherSceneEffectComp then
		self._weatherSceneEffectComp:onSceneClose()

		self._weatherSceneEffectComp = nil
	end

	self._weatherSceneEffectComp = WeatherSceneEffectComp.New()

	self._weatherSceneEffectComp:onInit(sceneId, true)
	self._weatherSceneEffectComp:initSceneGo(sceneGo)
end

function WeatherController:_onWeatherOnRoleBlend(param)
	if self._weatherSceneEffectComp then
		self._weatherSceneEffectComp:onRoleBlend(self._weatherComp, param[1], param[2])
	end
end

function WeatherController:setReportId(id)
	self._weatherComp:setReportId(id)
end

function WeatherController:getReportId()
	return self._weatherComp:getReportId()
end

function WeatherController:getPrevLightMode()
	return self._weatherComp:getPrevLightMode()
end

function WeatherController:getCurLightMode()
	return self._weatherComp:getCurLightMode()
end

function WeatherController:getCurrReport()
	return self._weatherComp:getCurrReport()
end

function WeatherController:getMainColor()
	return self._weatherComp:getMainColor()
end

function WeatherController:playWeatherAudio()
	self._weatherComp:playWeatherAudio()
end

function WeatherController:stopWeatherAudio()
	self._weatherComp:stopWeatherAudio()
end

function WeatherController:setStateByString(stateGroup, stateState)
	self._weatherComp:setStateByString(stateGroup, stateState)
end

function WeatherController:lerpColorRGBA(a, b, t)
	return self._weatherComp:lerpColorRGBA(a, b, t)
end

function WeatherController:onSceneHide(isFakeShow)
	if self._weatherComp then
		gohelper.setActive(self._weatherComp:getSceneGo(), isFakeShow and true or false)
		self._weatherComp:onSceneHide()
	end

	if self._eggContainer then
		self._eggContainer:onSceneHide()
	end

	if self._weatherSceneEffectComp then
		self._weatherSceneEffectComp:onSceneHide()
	end
end

function WeatherController:FakeShowScene(visible)
	if self._weatherComp then
		gohelper.setActive(self._weatherComp:getSceneGo(), visible)
	end
end

function WeatherController:onSceneShow()
	if self._weatherComp then
		gohelper.setActive(self._weatherComp:getSceneGo(), true)
		self._weatherComp:onSceneShow()
	end

	if self._eggContainer then
		self._eggContainer:onSceneShow()
	end

	if self._weatherSceneEffectComp then
		self._weatherSceneEffectComp:onSceneShow()
	end
end

function WeatherController:onSceneClose()
	self._weatherComp:onSceneClose()

	if self._eggContainer then
		self._eggContainer:onSceneClose()

		self._eggContainer = nil
	end
end

WeatherController.instance = WeatherController.New()

return WeatherController
