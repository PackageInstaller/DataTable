-- chunkname: @modules/logic/weather/eggs/SceneEggPreviewSceneTransition.lua

module("modules.logic.weather.eggs.SceneEggPreviewSceneTransition", package.seeall)

local SceneEggPreviewSceneTransition = class("SceneEggPreviewSceneTransition", SceneBaseEgg)

function SceneEggPreviewSceneTransition:_onEnable()
	if self._context.isMainScene then
		return
	end

	self:_showEffect()
end

function SceneEggPreviewSceneTransition:_onDisable()
	if self._context.isMainScene then
		return
	end

	self:_delayHideGoList()
end

function SceneEggPreviewSceneTransition:_showEffect()
	TaskDispatcher.cancelTask(self._delayHideGoList, self)
	TaskDispatcher.runDelay(self._delayHideGoList, self, 2)
	self:setGoListVisible(true)
	PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 0)
	MainSceneSwitchCameraController.instance:setUnitPPValue("sceneMaskTexDownTimes", 0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self, LuaEventSystem.High)
end

function SceneEggPreviewSceneTransition:_onOpenViewFinish(viewName)
	if viewName == ViewName.MainSceneSkinMaterialTipView then
		TaskDispatcher.cancelTask(self._delayHideGoList, self)
		self:_delayHideGoList()
	end
end

function SceneEggPreviewSceneTransition:_delayHideGoList()
	self:setGoListVisible(false)
	PostProcessingMgr.instance:setUnitPPValue("sceneMaskTexDownTimes", 1)
	MainSceneSwitchCameraController.instance:setUnitPPValue("sceneMaskTexDownTimes", 1)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function SceneEggPreviewSceneTransition:_onInit()
	if self._context.isMainScene then
		return
	end

	self:_showEffect()
end

function SceneEggPreviewSceneTransition:_onSceneClose()
	if self._context.isMainScene then
		return
	end

	TaskDispatcher.cancelTask(self._delayHideGoList, self)
	self:_delayHideGoList()
end

return SceneEggPreviewSceneTransition
