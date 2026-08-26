-- chunkname: @modules/logic/room/view/RoomViewUIBuildingItem.lua

module("modules.logic.room.view.RoomViewUIBuildingItem", package.seeall)

local RoomViewUIBuildingItem = class("RoomViewUIBuildingItem", RoomViewUIBaseItem)

function RoomViewUIBuildingItem:ctor(buildingUid)
	self._buildingUid = buildingUid
end

function RoomViewUIBuildingItem:_customOnInit()
	self._gomain = gohelper.findChild(self._gocontainer, "bubblebg/#go_main")
	self._imagebuildingicon = gohelper.findChildImage(self._gocontainer, "#image_buildingicon")
	self._txtnamecn = gohelper.findChildText(self._gocontainer, "bottom/txt_buildingName")
	self._goreddot = gohelper.findChild(self._gocontainer, "bottom/#go_reddot")

	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._buildingUid)

	if buildingMO then
		local config = buildingMO.config

		self._txtnamecn.text = config.name

		UISpriteSetMgr.instance:setCritterSprite(self._imagebuildingicon, RoomBuildingEnum.BuildingMapUiIcon[config.buildingType])
	end
end

function RoomViewUIBuildingItem:_customAddEventListeners()
	self:refreshUI(true)
end

function RoomViewUIBuildingItem:_customRemoveEventListeners()
	return
end

function RoomViewUIBuildingItem:_onClick(go, param)
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(self._buildingUid)

	if buildingMO then
		RoomMap3DClickController.instance:onBuildingEntityClick(buildingMO)
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	end
end

function RoomViewUIBuildingItem:refreshUI(isInit)
	self:_refreshShow(isInit)
	self:_refreshPosition()
end

function RoomViewUIBuildingItem:_refreshShow(isInit)
	if RoomBuildingController.instance:isBuildingListShow() or RoomCharacterController.instance:isCharacterListShow() then
		self:_setShow(false, isInit)

		return
	end

	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Overlook and cameraState ~= RoomEnum.CameraState.OverlookAll then
		self:_setShow(false, isInit)

		return
	end

	if RoomMapController.instance:isInRoomInitBuildingViewCamera() then
		self:_setShow(false, isInit)

		return
	end

	self:_setShow(true, isInit)
end

function RoomViewUIBuildingItem:getUI3DPos()
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(self._buildingUid, SceneTag.RoomBuilding)

	if not buildingEntity then
		self:_setShow(false, true)

		return Vector3.zero
	end

	local headGO = buildingEntity:getHeadGO()

	if headGO then
		return headGO.transform.position
	end

	return buildingEntity.goTrs.position
end

function RoomViewUIBuildingItem:_customOnDestory()
	return
end

return RoomViewUIBuildingItem
