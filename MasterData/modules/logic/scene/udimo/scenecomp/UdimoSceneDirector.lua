-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneDirector.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneDirector", package.seeall)

local UdimoSceneDirector = class("UdimoSceneDirector", BaseSceneComp)

function UdimoSceneDirector:onInit()
	return
end

function UdimoSceneDirector:onSceneStart(sceneId, levelId)
	self:disposeCompInitSeq()

	local scene = self:getCurScene()

	self._compInitFlow = FlowSequence.New()

	self._compInitFlow:addWork(RoomSceneWaitEventCompWork.New(scene.level, CommonSceneLevelComp.OnLevelLoaded))
	self._compInitFlow:addWork(RoomSceneCommonCompWork.New(scene.loader))
	self._compInitFlow:addWork(RoomSceneCommonCompWork.New(scene.graphics))
	self._compInitFlow:addWork(RoomSceneCommonCompWork.New(scene.decoration))
	self._compInitFlow:addWork(RoomSceneCommonCompWork.New(scene.stayPoint))
	self._compInitFlow:addWork(RoomSceneCommonCompWork.New(scene.interactPoint))
	self._compInitFlow:addWork(RoomSceneCommonCompWork.New(scene.udimomgr))
	self._compInitFlow:addWork(RoomSceneCommonCompWork.New(scene.timeAnim))
	self._compInitFlow:addWork(RoomSceneCommonCompWork.New(scene.weather))
	self._compInitFlow:registerDoneListener(self._compInitDone, self)
	self._compInitFlow:start({
		sceneId = sceneId,
		levelId = levelId
	})
end

function UdimoSceneDirector:_compInitDone()
	self:disposeCompInitSeq()

	local scene = self:getCurScene()

	scene:onPrepared()
	self:disposeCompLateInitSeq()

	self._compLateInitFlow = FlowSequence.New()

	self._compLateInitFlow:addWork(WaitEventWork.New("GameSceneMgr;SceneEventName;LoadingAnimEnd"))
	self._compLateInitFlow:addWork(RoomSceneCommonCompWork.New(scene.view))
	self._compLateInitFlow:registerDoneListener(self._compLateInitDone, self)
	self._compLateInitFlow:start({})
end

function UdimoSceneDirector:_compLateInitDone()
	RoomController.instance:dispatchEvent(UdimoEvent.OnSceneLateInitDone)
end

function UdimoSceneDirector:disposeCompInitSeq()
	if not self._compInitFlow then
		return
	end

	self._compInitFlow:unregisterDoneListener(self._compInitDone, self)
	self._compInitFlow:destroy()

	self._compInitFlow = nil
end

function UdimoSceneDirector:disposeCompLateInitSeq()
	if not self._compLateInitFlow then
		return
	end

	self._compLateInitFlow:unregisterDoneListener(self._compLateInitDone, self)
	self._compLateInitFlow:destroy()

	self._compLateInitFlow = nil
end

function UdimoSceneDirector:onSceneClose()
	self:disposeCompInitSeq()
	self:disposeCompLateInitSeq()
end

return UdimoSceneDirector
