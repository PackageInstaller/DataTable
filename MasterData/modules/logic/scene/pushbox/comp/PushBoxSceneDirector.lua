-- chunkname: @modules/logic/scene/pushbox/comp/PushBoxSceneDirector.lua

module("modules.logic.scene.pushbox.comp.PushBoxSceneDirector", package.seeall)

local PushBoxSceneDirector = class("PushBoxSceneDirector", BaseSceneComp)

function PushBoxSceneDirector:onInit()
	self._scene = self:getCurScene()
end

function PushBoxSceneDirector:onSceneStart(sceneId, levelId)
	self._scene.preloader:startPreload()
end

function PushBoxSceneDirector:onPushBoxAssetLoadFinish()
	self:_onRefreshActivityData()
end

function PushBoxSceneDirector:_onRefreshActivityData()
	self._scene:onPrepared()
end

function PushBoxSceneDirector:onSceneClose()
	return
end

return PushBoxSceneDirector
