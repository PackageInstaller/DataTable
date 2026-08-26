-- chunkname: @modules/logic/scene/survivalcollectionroom/comp/SurvivalCollectionRoomDirector.lua

module("modules.logic.scene.survivalcollectionroom.comp.SurvivalCollectionRoomDirector", package.seeall)

local SurvivalCollectionRoomDirector = class("SurvivalCollectionRoomDirector", BaseSceneComp)

function SurvivalCollectionRoomDirector:onInit()
	self._scene = self:getCurScene()
end

function SurvivalCollectionRoomDirector:onSceneStart(sceneId, levelId)
	self._beginDt = ServerTime.now()
	self._compInitSequence = FlowSequence.New()

	local levelAndPreloadWork = FlowParallel.New()

	self._compInitSequence:addWork(levelAndPreloadWork)
	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.level, CommonSceneLevelComp.OnLevelLoaded))

	if self._scene.fog then
		levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.fog, SurvivalEvent.OnSurvivalFogLoaded))
	end

	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.block, SurvivalEvent.OnSurvivalBlockLoadFinish))

	if self._scene.spBlock then
		levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.spBlock, SurvivalEvent.OnSurvivalBlockLoadFinish))
	end

	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.preloader, SurvivalEvent.OnSurvivalPreloadFinish))

	if self._scene.cloud then
		self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.cloud))
	end

	self._compInitSequence:addWork(BpWaitSecWork.New(0.3))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.graphics))
	self._compInitSequence:addWork(BpWaitSecWork.New(0.3))
	self._compInitSequence:registerDoneListener(self._compInitDone, self)
	self._compInitSequence:start({
		sceneId = sceneId,
		levelId = levelId
	})
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, self.onOpenView, self)
end

function SurvivalCollectionRoomDirector:onOpenView(viewName)
	if viewName == ViewName.SurvivalCollectionRoomView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenView, self)
		ViewMgr.instance:closeView(ViewName.SurvivalLoadingView, true)
	end
end

function SurvivalCollectionRoomDirector:_compInitDone()
	self._scene:onPrepared()

	self._compInitSequence = nil

	ViewMgr.instance:openView(ViewName.SurvivalCollectionRoomView)
end

function SurvivalCollectionRoomDirector:onSceneClose()
	if self._compInitSequence then
		self._compInitSequence:destroy()

		self._compInitSequence = nil
	end

	ViewMgr.instance:closeView(ViewName.SurvivalCollectionRoomView, true)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, self.onOpenView, self)
	SurvivalStatHelper.instance:statCollectionRoomClose(ServerTime.now() - self._beginDt)
end

return SurvivalCollectionRoomDirector
