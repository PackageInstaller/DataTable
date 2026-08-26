-- chunkname: @modules/logic/partygame/scene/comp/PartyGameSceneDirector.lua

module("modules.logic.partygame.scene.comp.PartyGameSceneDirector", package.seeall)

local PartyGameSceneDirector = class("PartyGameSceneDirector", BaseSceneComp)

function PartyGameSceneDirector:onInit()
	self._scene = self:getCurScene()
	self.animSuccess = false
	self.switchSuccess = false
end

function PartyGameSceneDirector:_onLevelLoaded()
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
	self:_check()
	TaskDispatcher.runRepeat(self._check, self, 0.1)
end

function PartyGameSceneDirector:_check()
	local curPartyGame = PartyGameController.instance:getCurPartyGame()

	if self._isPreloadedViewRes and curPartyGame:isInitFinish() and curPartyGame:canEndLoading() then
		TaskDispatcher.cancelTask(self._check, self)
		self._scene:onPrepared()
		PartyGameController.instance:gameLoadingFinish()

		local curGame = PartyGameController.instance:getCurPartyGame()

		if curGame:getIsLocal() then
			PartyGameController.instance:gamePause(false)
		end
	end
end

function PartyGameSceneDirector:onSceneStart(sceneId, levelId)
	self._isPreloadedViewRes = false

	self._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)

	local curGame = PartyGameController.instance:getCurPartyGame()
	local viewName = curGame and curGame:getGameViewName()

	if not string.nilorempty(viewName) then
		local setting = ViewMgr.instance:getSetting(viewName)

		module_views_preloader._startLoad({
			setting and setting.mainRes
		}, self._onLoadedViewRes, self)
	else
		self._isPreloadedViewRes = true
	end
end

function PartyGameSceneDirector:_onLoadedViewRes()
	self._isPreloadedViewRes = true
end

function PartyGameSceneDirector:onScenePrepared(sceneId, levelId)
	return
end

function PartyGameSceneDirector:onSceneClose()
	TaskDispatcher.cancelTask(self._check, self)
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

return PartyGameSceneDirector
