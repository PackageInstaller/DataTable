-- chunkname: @modules/logic/scene/room/comp/RoomSceneDirector.lua

module("modules.logic.scene.room.comp.RoomSceneDirector", package.seeall)

local RoomSceneDirector = class("RoomSceneDirector", BaseSceneComp)

function RoomSceneDirector:onInit()
	return
end

function RoomSceneDirector:onSceneStart(sceneId, levelId)
	RoomHelper.logElapse("RoomSceneDirector:onSceneStart")

	local quality = GameGlobalMgr.instance:getScreenState():getLocalQuality()

	UnityEngine.QualitySettings.globalTextureMipmapLimit = quality == ModuleEnum.Performance.Low and 1 or 0

	RoomHelper.logElapse("RoomSceneDirector:set globalTextureMipmapLimit")
	RoomPreloadMgr.instance:dispose()

	self._scene = self:getCurScene()
	self._compInitSequence = FlowSequenceRoom.New()

	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.tween))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.timer))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.init))

	local levelAndPreloadWork = FlowParallelRoom.New()

	self._compInitSequence:addWork(levelAndPreloadWork)
	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.level, CommonSceneLevelComp.OnLevelLoaded))
	levelAndPreloadWork:addWork(RoomSceneWaitEventCompWork.New(self._scene.preloader, RoomScenePreloader.OnPreloadFinish))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.loader))
	self._compInitSequence:addWork(WorkWaitSeconds.New(0.01))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.bloom))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.go))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.fog))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.bending))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.ocean))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.light))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.weather))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.mapmgr))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.inventorymgr))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.buildingmgr))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.sitemgr))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.graphics))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.ambient))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.camera))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.cameraFollow))
	self._compInitSequence:addWork(RoomPreloadCharacterWork.New())
	self._compInitSequence:registerDoneListener(self._compInitDone, self)
	self._compInitSequence:start({
		sceneId = sceneId,
		levelId = levelId
	})
end

function RoomSceneDirector:_compInitDone()
	self:_getInteractionReward()

	local gameScreenState = GameGlobalMgr.instance:getScreenState()

	gameScreenState:resetMaxFileLoadingCount()
	self._scene:onPrepared()
	RoomHelper.logElapse("onPrepared")

	local isResetEdit = RoomMapController.instance:isResetEdit()

	if isResetEdit then
		RoomMapController.instance:dispatchEvent(RoomEvent.Reset)
	end

	RoomHelper.initSceneRootTrs()

	local preSceneType = GameSceneMgr.instance:getPreSceneType()

	if preSceneType == SceneType.Room then
		if RoomController.instance:isObMode() then
			self._scene.camera:playCameraAnim("out_show")
		elseif RoomController.instance:isEditMode() then
			self._scene.camera:playCameraAnim("out_edit")
		else
			self._scene.camera:playCameraAnim("idle")
		end
	else
		self._scene.camera:playCameraAnim("idle")
		RoomMapController.instance:statRoomStart()
	end

	self._compLateInitFlow = FlowParallelRoom.New()

	local flowSequence1 = FlowSequenceRoom.New()
	local flowSequence2 = FlowSequenceRoom.New()

	self._compLateInitFlow:addWork(flowSequence1)
	self._compLateInitFlow:addWork(flowSequence2)
	flowSequence1:addWork(WorkWaitSeconds.New(0.2))
	flowSequence1:addWork(RoomSceneWaitEventCompWork.New(self._scene.view, RoomSceneViewComp.OnOpenView))

	if self._scene.confirmview then
		flowSequence1:addWork(RoomSceneCommonCompWork.New(self._scene.confirmview))
	end

	flowSequence1:addWork(RoomSceneCommonCompWork.New(self._scene.debug))
	flowSequence1:addWork(RoomSceneCommonCompWork.New(self._scene.audio))
	flowSequence2:addWork(WorkWaitSeconds.New(0.01))
	flowSequence2:addWork(RoomSceneCommonCompWork.New(self._scene.touch))
	flowSequence2:addWork(RoomSceneCommonCompWork.New(self._scene.path))
	flowSequence2:addWork(RoomSceneWaitAStarWork.New(self._scene))
	flowSequence2:addWork(RoomSceneCommonCompWork.New(self._scene.character))
	flowSequence2:addWork(RoomSceneCommonCompWork.New(self._scene.charactermgr))
	flowSequence2:addWork(RoomSceneCommonCompWork.New(self._scene.fovblock))
	flowSequence2:addWork(RoomSceneCommonCompWork.New(self._scene.vehiclemgr))
	flowSequence2:addWork(RoomSceneCommonCompWork.New(self._scene.crittermgr))
	flowSequence2:addWork(RoomSceneCommonCompWork.New(self._scene.buildingcrittermgr))
	flowSequence2:addWork(RoomSceneCommonCompWork.New(self._scene.fsm))
	flowSequence2:addWork(RoomSceneCharacterInteractionWork.New(self._scene))
	flowSequence1:addWork(WorkWaitSeconds.New(0.1))
	flowSequence1:addWork(RoomSceneWaitEventCompWork.New(self._scene.view, RoomSceneViewComp.OnOpenView))
	flowSequence2:addWork(WorkWaitSeconds.New(0.5))
	self._compLateInitFlow:registerDoneListener(self._compLateInitDone, self)
	self._compLateInitFlow:start({})
end

function RoomSceneDirector:switchMode()
	if RoomController.instance:isObMode() then
		self._scene.fsm:triggerEvent(RoomSceneEvent.CancelBackBlock)
		self._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBlock)
		self._scene.fsm:triggerEvent(RoomSceneEvent.CancelPlaceBuilding)
	end

	local needRebuildPath = RoomController.instance:isObMode() and (RoomModel.instance:hasEdit() or RoomController.instance:isReset())

	RoomModel.instance:clearEditFlag()
	self._scene.view:onSceneClose()
	self._scene.camera:onSceneClose()
	self._scene.init:onSceneClose()
	self._scene.audio:onSceneClose()

	if RoomController.instance:isReset() then
		RoomMapController.instance:initMap()
		self._scene.mapmgr:onSwitchMode()
		self._scene.inventorymgr:onSceneClose()
		self._scene.buildingmgr:onSwitchMode()
		self._scene.sitemgr:onSwitchMode()
		self._scene.vehiclemgr:onStopMode()
	end

	if needRebuildPath then
		self._scene.path:doNeedPathGOs()
		self._scene.path:onSceneClose()
	end

	self._scene.character:onSceneClose()
	self._scene.charactermgr:onSceneClose()
	self._scene.fovblock:onSceneClose()
	self._scene.crittermgr:onSceneClose()
	self._scene.buildingcrittermgr:onSceneClose()
	self._scene.fsm:onSceneClose()
	self._scene.preloader:clearPools()
	GameGCMgr.instance:dispatchEvent(GameGCEvent.ResGC, self)

	self._switchModeInitFlow = FlowSequenceRoom.New()

	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.init))
	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.camera))

	if RoomController.instance:isReset() then
		self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.mapmgr))
		self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.inventorymgr))
		self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.buildingmgr))
		self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.sitemgr))
		self._switchModeInitFlow:addWork(RoomSceneWaitEventCompWork.New(self._scene.preloader, RoomScenePreloader.OnPreloadFinish))
	end

	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.audio))
	self._switchModeInitFlow:addWork(RoomPreloadCharacterWork.New())

	if needRebuildPath then
		self._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.01))
		self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.path))
	end

	self._switchModeInitFlow:addWork(RoomSceneWaitAStarWork.New(self._scene))
	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.character))
	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.charactermgr))
	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.fovblock))
	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.fsm))
	self._switchModeInitFlow:addWork(RoomSceneCharacterInteractionWork.New(self._scene))
	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.ambient))
	self._compInitSequence:addWork(RoomSceneCommonCompWork.New(self._scene.cameraFollow))
	self._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.01))
	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.crittermgr))
	self._switchModeInitFlow:addWork(RoomSceneCommonCompWork.New(self._scene.buildingcrittermgr))
	self._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.01))
	self._switchModeInitFlow:addWork(RoomSceneWaitEventCompWork.New(self._scene.view, RoomSceneViewComp.OnOpenView))
	self._switchModeInitFlow:addWork(WorkWaitSeconds.New(0.1))
	self._switchModeInitFlow:registerDoneListener(self._switchModeInitDone, self)
	self._switchModeInitFlow:start({})
end

function RoomSceneDirector:_compLateInitDone()
	RoomHelper.logElapse("late init done")
	RoomController.instance:dispatchEvent(RoomEvent.OnLateInitDone)
end

function RoomSceneDirector:_switchModeInitDone()
	RoomHelper.logElapse("switch mode init done")

	if RoomController.instance:isObMode() then
		self._scene.camera:playCameraAnim("out_show")
	elseif RoomController.instance:isEditMode() then
		self._scene.camera:playCameraAnim("out_edit")
	else
		self._scene.camera:playCameraAnim("idle")
	end

	self._scene.vehiclemgr:onSwitchMode()
	RoomController.instance:dispatchEvent(RoomEvent.OnSwitchModeDone)
end

function RoomSceneDirector:_getInteractionReward()
	if not RoomController.instance:isObMode() then
		return
	end

	local existInteractionDict = RoomModel.instance:getExistInteractionDict()

	for id, state in pairs(existInteractionDict) do
		if state == RoomCharacterEnum.InteractionState.Start and not RoomCharacterHelper.interactionIsDialogWithSelect(id) then
			RoomRpc.instance:sendGetCharacterInteractionBonusRequest(id)
		end
	end
end

function RoomSceneDirector:onSceneClose()
	ViewMgr.instance:closeAllPopupViews()
	self._compInitSequence:unregisterDoneListener(self._compInitDone, self)
	self._compInitSequence:stop()

	self._compInitSequence = nil

	if self._compLateInitFlow then
		self._compLateInitFlow:unregisterDoneListener(self._compInitDone, self)
		self._compLateInitFlow:stop()

		self._compLateInitFlow = nil
	end

	if self._switchModeInitFlow then
		self._switchModeInitFlow:unregisterDoneListener(self._switchModeInitDone, self)
		self._switchModeInitFlow:stop()

		self._switchModeInitFlow = nil
	end

	ZProj.RoomHelper.ReleaseRaycastHitsAlloc()
end

return RoomSceneDirector
