-- chunkname: @modules/logic/weather/eggs/SceneEggMainSceneTransition.lua

module("modules.logic.weather.eggs.SceneEggMainSceneTransition", package.seeall)

local SceneEggMainSceneTransition = class("SceneEggMainSceneTransition", SceneBaseEgg)

function SceneEggMainSceneTransition:_onEnable()
	if not self._context.isMainScene then
		return
	end
end

function SceneEggMainSceneTransition:_onDisable()
	if not self._context.isMainScene then
		return
	end
end

function SceneEggMainSceneTransition:_onInit()
	if not self._context.isMainScene then
		return
	end

	self._showSecond = tonumber(self._eggConfig.actionParams)

	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, self._onMainPopupFlowFinish, self)
	WeatherController.instance:registerCallback(WeatherEvent.MainViewHideTimeUpdate, self._onMainViewHideTimeUpdate, self)
end

function SceneEggMainSceneTransition:_onMainViewHideTimeUpdate(time)
	if time and time >= self._showSecond then
		WeatherSceneController.instance:clearInfo()
		self:_showEffect()
	end
end

function SceneEggMainSceneTransition:_onMainPopupFlowFinish()
	local zeroTime = self:_getZeroTime()

	PlayerPrefsHelper.setNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SceneEggMainSceneTransition), zeroTime)
	self:_showEffect()
end

function SceneEggMainSceneTransition:_showEffect()
	TaskDispatcher.cancelTask(self._delayHideGoList, self)
	TaskDispatcher.runDelay(self._delayHideGoList, self, 2)
	self:setGoListVisible(true)
	PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "SceneEggMainSceneTransition", true)
end

function SceneEggMainSceneTransition:_delayHideGoList()
	self:setGoListVisible(false)
	PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 1)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "SceneEggMainSceneTransition", false)
end

function SceneEggMainSceneTransition:_onSceneClose()
	if not self._context.isMainScene then
		return
	end

	MainController.instance:unregisterCallback(MainEvent.OnMainPopupFlowFinish, self._onMainPopupFlowFinish, self)
	WeatherController.instance:unregisterCallback(WeatherEvent.MainViewHideTimeUpdate, self._onMainViewHideTimeUpdate, self)
	TaskDispatcher.cancelTask(self._delayHideGoList, self)
	self:_delayHideGoList()
end

function SceneEggMainSceneTransition:_hasDailyShow()
	local zeroTime = self:_getZeroTime()
	local saveZeroTime = PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.SceneEggMainSceneTransition), 0)

	if zeroTime ~= saveZeroTime then
		return true
	end

	return false
end

function SceneEggMainSceneTransition:_getZeroTime()
	local nowDate = os.date("*t", os.time())

	nowDate.hour = 0
	nowDate.min = 0
	nowDate.sec = 0

	return (os.time(nowDate))
end

return SceneEggMainSceneTransition
