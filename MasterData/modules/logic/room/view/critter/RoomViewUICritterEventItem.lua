-- chunkname: @modules/logic/room/view/critter/RoomViewUICritterEventItem.lua

module("modules.logic.room.view.critter.RoomViewUICritterEventItem", package.seeall)

local RoomViewUICritterEventItem = class("RoomViewUICritterEventItem", RoomViewUIBaseItem)

function RoomViewUICritterEventItem:ctor(critterUid)
	RoomViewUICritterEventItem.super.ctor(self)

	self._showCameraStateDict = {
		[RoomEnum.CameraState.OverlookAll] = true
	}
	self.critterUid = critterUid
	self.critterMO = CritterModel.instance:getCritterMOByUid(self.critterUid)
	self.eventType = CritterHelper.getEventTypeByCritterMO(self.critterMO) or CritterEnum.CritterItemEventType.SurpriseCollect
end

function RoomViewUICritterEventItem:_customOnInit()
	self._gobg = gohelper.findChildImage(self._gocontainer, "bg")
	self._gocrittericon = gohelper.findChild(self._gocontainer, "#go_crittericon")
	self._goEventBubble = gohelper.findChild(self._gocontainer, "#image_bubble")
	self._imageEventBubble = gohelper.findChildImage(self._gocontainer, "#image_bubble")
	self._goPropBubble = gohelper.findChild(self._gocontainer, "bubblebg")
	self._simageProp = gohelper.findChildSingleImage(self._gocontainer, "#image_bubble")
end

function RoomViewUICritterEventItem:_customAddEventListeners()
	RoomCharacterController.instance:registerCallback(RoomEvent.CharacterPositionChanged, self._characterPositionChanged, self)
	self:setIconUI()
	self:refreshUI(true)
end

function RoomViewUICritterEventItem:_customRemoveEventListeners()
	RoomCharacterController.instance:unregisterCallback(RoomEvent.CharacterPositionChanged, self._characterPositionChanged, self)
end

function RoomViewUICritterEventItem:_characterPositionChanged(heroId)
	if self.critterMO and self.critterMO.trainInfo.heroId ~= heroId then
		return
	end

	self:_refreshPosition()
end

function RoomViewUICritterEventItem:_onClick(go, param)
	if self.eventType == CritterEnum.CritterItemEventType.HasTrainEvent then
		self:_clickTrainEvent()
	end

	if self.eventType == CritterEnum.CritterItemEventType.NoMoodWork then
		self:_clickNoMoodWorking()
	end
end

function RoomViewUICritterEventItem:_clickNoMoodWorking()
	local buildingUid = ManufactureModel.instance:getCritterWorkingBuilding(self.critterUid)

	RoomMap3DClickController.instance:onBuildingEntityClick(RoomMapBuildingModel.instance:getBuildingMOById(buildingUid))
end

function RoomViewUICritterEventItem:_clickTrainEvent()
	if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
		RoomCritterController.instance:openTrainEventView(self.critterUid)
	else
		ManufactureController.instance:openCritterBuildingView(nil, RoomCritterBuildingViewContainer.SubViewTabId.Training, self.critterUid)
	end
end

local EventTypeIconMap = {
	[CritterEnum.CritterItemEventType.HasTrainEvent] = "critter_mapbubble1",
	[CritterEnum.CritterItemEventType.TrainEventComplete] = "critter_mapbubble2",
	[CritterEnum.CritterItemEventType.NoMoodWork] = "critter_mapbubble3"
}

function RoomViewUICritterEventItem:setIconUI()
	self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocrittericon)

	self.critterIcon:onUpdateMO(self.critterMO)

	local hasProp = self.eventType == CritterEnum.CritterItemEventType.SurpriseCollect

	if hasProp then
		-- block empty
	else
		local icon = EventTypeIconMap[self.eventType]

		UISpriteSetMgr.instance:setCritterSprite(self._imageEventBubble, icon)
	end

	gohelper.setActive(self._goPropBubble, hasProp)
	gohelper.setActive(self._goEventBubble, not hasProp)
end

function RoomViewUICritterEventItem:refreshUI(isInit)
	self:_refreshShow(isInit)
	self:_refreshPosition()
end

function RoomViewUICritterEventItem:_refreshShow(isInit)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		self:_setShow(false, isInit)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() or not self._showCameraStateDict[self._scene.camera:getCameraState()] then
		self:_setShow(false, isInit)

		return
	end

	self:_setShow(true, isInit)
end

function RoomViewUICritterEventItem:getUI3DPos()
	local critterEntity = self:getEventCritterEntity()

	if not critterEntity then
		return Vector3.zero
	end

	local trs = critterEntity.critterspine:getMountheadGOTrs() or critterEntity.goTrs

	if not trs then
		return Vector3.zero
	end

	local px, py, pz = transformhelper.getPos(trs)

	return Vector3(px, py, pz)
end

function RoomViewUICritterEventItem:getEventCritterEntity()
	local result
	local isCultivating = self.critterMO:isCultivating()

	return isCultivating and self._scene.crittermgr:getCritterEntity(self.critterUid, SceneTag.RoomCharacter) or self._scene.buildingcrittermgr:getCritterEntity(self.critterUid, SceneTag.RoomCharacter)
end

function RoomViewUICritterEventItem:_customOnDestory()
	self._simageProp:UnLoadImage()
end

RoomViewUICritterEventItem.prefabPath = "ui/viewres/room/sceneui/roomscenecritterheadui.prefab"

return RoomViewUICritterEventItem
