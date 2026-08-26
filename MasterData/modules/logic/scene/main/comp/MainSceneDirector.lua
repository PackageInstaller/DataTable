-- chunkname: @modules/logic/scene/main/comp/MainSceneDirector.lua

module("modules.logic.scene.main.comp.MainSceneDirector", package.seeall)

local MainSceneDirector = class("MainSceneDirector", BaseSceneComp)

function MainSceneDirector:onInit()
	self._scene = self:getCurScene()
	self.animSuccess = false
	self.switchSuccess = false
end

function MainSceneDirector:_onLevelLoaded()
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)

	local sceneGo = self._scene.level:getSceneGo()

	WeatherController.instance:initSceneGo(sceneGo, self._onSwitchResLoaded, self)
	self._scene.yearAnimation:initAnimationCurve(self._onAnimationCurveLoaded, self)
	PartyGameLobbyController.instance:sendPartyServerListRequest()
end

function MainSceneDirector:_onAnimationCurveLoaded()
	self.animSuccess = true

	self:_check()
end

function MainSceneDirector:_onSwitchResLoaded()
	self.switchSuccess = true

	self:_check()
end

function MainSceneDirector:_check()
	if self.animSuccess and self.switchSuccess then
		self._scene:onPrepared()
	end
end

function MainSceneDirector:onSceneStart(sceneId, levelId)
	self._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function MainSceneDirector:onScenePrepared(sceneId, levelId)
	return
end

function MainSceneDirector:onSceneClose()
	self.animSuccess = false
	self.switchSuccess = false

	MainController.instance:dispatchEvent(MainEvent.OnSceneClose)
	MainController.instance:clearOpenMainViewFlag()
	ViewMgr.instance:closeAllPopupViews({
		ViewName.SummonADView
	})
	WeatherController.instance:onSceneClose()
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

return MainSceneDirector
