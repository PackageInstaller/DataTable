-- chunkname: @modules/logic/weather/controller/WeatherSceneController.lua

module("modules.logic.weather.controller.WeatherSceneController", package.seeall)

local WeatherSceneController = class("WeatherSceneController", BaseController)

function WeatherSceneController:onInit()
	self:clearInfo()
end

function WeatherSceneController:reInit()
	self:clearInfo()
end

function WeatherSceneController:clearInfo()
	self._hideMainViewTime = 0
	self._hideStartTime = nil
end

function WeatherSceneController:onInitFinish()
	return
end

function WeatherSceneController:addConstEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self._onOpenView, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	MainController.instance:registerCallback(MainEvent.OnDailyPopupFlowFinish, self._onDailyPopupFlowFinish, self)
end

function WeatherSceneController:_onOpenView(viewName)
	if not MainSceneSwitchEnum.SpSceneMap[MainSceneSwitchModel.instance:getCurSceneId()] then
		self:clearInfo()

		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.MainView) then
		self._hideStartTime = self._hideStartTime or Time.time
	end
end

function WeatherSceneController:_onCloseView(viewName)
	if not MainSceneSwitchEnum.SpSceneMap[MainSceneSwitchModel.instance:getCurSceneId()] then
		self:clearInfo()

		return
	end

	if ViewHelper.instance:checkViewOnTheTop(ViewName.MainView) and self._hideStartTime then
		self._hideMainViewTime = self._hideMainViewTime + Time.time - self._hideStartTime
		self._hideStartTime = nil

		local inPopupFlow = MainController.instance:isInPopupFlow()

		if inPopupFlow then
			return
		end

		WeatherController.instance:dispatchEvent(WeatherEvent.MainViewHideTimeUpdate, self._hideMainViewTime)
	end
end

function WeatherSceneController:_onDailyPopupFlowFinish()
	WeatherController.instance:dispatchEvent(WeatherEvent.MainViewHideTimeUpdate, self._hideMainViewTime)
end

WeatherSceneController.instance = WeatherSceneController.New()

return WeatherSceneController
