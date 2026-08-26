-- chunkname: @modules/logic/scene/common/CommonSceneDirector.lua

module("modules.logic.scene.common.CommonSceneDirector", package.seeall)

local CommonSceneDirector = class("CommonSceneDirector", BaseSceneComp)

function CommonSceneDirector:onInit()
	self._scene = self:getCurScene()
end

function CommonSceneDirector:onSceneStart(sceneId, levelId)
	self._scene.level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function CommonSceneDirector:onSceneClose()
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
end

function CommonSceneDirector:_onLevelLoaded(levelId)
	self._scene.level:unregisterCallback(CommonSceneLevelComp.OnLevelLoaded, self._onLevelLoaded, self)
	self._scene:onPrepared()
end

return CommonSceneDirector
