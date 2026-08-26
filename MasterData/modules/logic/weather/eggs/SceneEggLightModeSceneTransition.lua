-- chunkname: @modules/logic/weather/eggs/SceneEggLightModeSceneTransition.lua

module("modules.logic.weather.eggs.SceneEggLightModeSceneTransition", package.seeall)

local SceneEggLightModeSceneTransition = class("SceneEggLightModeSceneTransition", SceneBaseEgg)

function SceneEggLightModeSceneTransition:_onInit()
	local lightModeList = GameUtil.splitString2(self._eggConfig.actionParams, true, "|", "#")

	self._fromLightModeList = lightModeList[1]
	self._toLightModeList = lightModeList[2]

	local t = lightModeList[3]

	self._delayTime = t and tonumber(t[1])

	if not self._delayTime then
		logError("SceneEggLightModeSceneTransition delayTime is nil egge id:", self._eggConfig.id)
	end

	self._showGoList = false

	self:setGoListVisible(false)
end

function SceneEggLightModeSceneTransition:_onDisable()
	TaskDispatcher.cancelTask(self._delayHideGoList, self)

	if self._showGoList then
		self._showGoList = false

		self:_delayHideGoList()
	end

	self._prevReport = nil
end

function SceneEggLightModeSceneTransition:_onReportChange(report)
	if not report then
		self:setGoListVisible(false)

		return
	end

	TaskDispatcher.cancelTask(self._delayHideGoList, self)

	if self._prevReport and tabletool.indexOf(self._fromLightModeList, self._prevReport.lightMode) and tabletool.indexOf(self._toLightModeList, report.lightMode) then
		self._showGoList = true

		self:setGoListVisible(true)
		TaskDispatcher.runDelay(self._delayHideGoList, self, self._delayTime)

		if self._context.isMainScene then
			PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 0)
			GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "SceneEggMainSceneTransition", true)
		else
			PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 0)
			MainSceneSwitchCameraController.instance:setUnitPPValue("sceneMaskTexDownTimes", 0)
		end
	elseif self._showGoList then
		self._showGoList = false

		self:_delayHideGoList()
	end

	self._prevReport = report
end

function SceneEggLightModeSceneTransition:_delayHideGoList()
	self:setGoListVisible(false)

	if self._context.isMainScene then
		PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 1)
		GameGCMgr.instance:dispatchEvent(GameGCEvent.SetBanGc, "SceneEggMainSceneTransition", false)
	else
		PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 1)
		MainSceneSwitchCameraController.instance:setUnitPPValue("sceneMaskTexDownTimes", 1)
	end
end

function SceneEggLightModeSceneTransition:_onSceneClose()
	TaskDispatcher.cancelTask(self._delayHideGoList, self)
	self:_delayHideGoList()
end

return SceneEggLightModeSceneTransition
