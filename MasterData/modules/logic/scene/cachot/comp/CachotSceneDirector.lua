-- chunkname: @modules/logic/scene/cachot/comp/CachotSceneDirector.lua

module("modules.logic.scene.cachot.comp.CachotSceneDirector", package.seeall)

local CachotSceneDirector = class("CachotSceneDirector", BaseSceneComp)

function CachotSceneDirector:onInit()
	self._scene = self:getCurScene()
end

function CachotSceneDirector:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()
	self._compInitSequence = FlowSequence.New()

	self._compInitSequence:addWork(RoomSceneWaitEventCompWork.New(self._scene.preloader, V1a6_CachotEvent.ScenePreloaded))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.player))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.event))
	self._compInitSequence:registerDoneListener(self._compInitDone, self)
	self._compInitSequence:start({
		sceneId = sceneId,
		levelId = levelId
	})
end

function CachotSceneDirector:_compInitDone()
	self._scene:onPrepared()

	self._compInitSequence = nil
end

function CachotSceneDirector:onSceneClose()
	if self._compInitSequence then
		self._compInitSequence:onDestroy()

		self._compInitSequence = nil
	end
end

return CachotSceneDirector
