-- chunkname: @modules/logic/roomfishing/view/RoomViewUIFishingStoreItem.lua

module("modules.logic.roomfishing.view.RoomViewUIFishingStoreItem", package.seeall)

local RoomViewUIFishingStoreItem = class("RoomViewUIFishingStoreItem", RoomViewUIBaseItem)

function RoomViewUIFishingStoreItem:_customOnInit()
	self._gomain = gohelper.findChild(self._gocontainer, "bubblebg/#go_main")
	self._imagebuildingicon = gohelper.findChildImage(self._gocontainer, "#image_buildingicon")
	self._txtnamecn = gohelper.findChildText(self._gocontainer, "bottom/txt_buildingName")
	self._txtnamecn.text = luaLang("RoomFishing_StoreItem")

	UISpriteSetMgr.instance:setCritterSprite(self._imagebuildingicon, "critter_buildingicon_6")
	gohelper.setActive(self._gomain, true)
end

function RoomViewUIFishingStoreItem:_customAddEventListeners()
	self.addEventCb(self, FishingController.instance, FishingEvent.GuideTouchFishingStore, self._onClick, self)
	self:refreshUI(true)
end

function RoomViewUIFishingStoreItem:_customRemoveEventListeners()
	self.removeEventCb(self, FishingController.instance, FishingEvent.GuideTouchFishingStore, self._onClick, self)
end

function RoomViewUIFishingStoreItem:_onClick(go, param)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	FishingController.instance:openFishingStoreView()
end

function RoomViewUIFishingStoreItem:refreshUI(isInit)
	self:_refreshShow(isInit)
	self:_refreshPosition()
end

function RoomViewUIFishingStoreItem:_refreshShow(isInit)
	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Overlook and cameraState ~= RoomEnum.CameraState.OverlookAll then
		self:_setShow(false, isInit)

		return
	end

	local hasBuilding = self:getBuildingEntity() ~= nil

	self:_setShow(hasBuilding, isInit)
end

function RoomViewUIFishingStoreItem:getUI3DPos()
	local buildingEntity = self:getBuildingEntity()

	if not buildingEntity then
		self:_setShow(false, true)

		return Vector3.zero
	end

	local containerGo = buildingEntity.containerGO
	local headGO = buildingEntity:getHeadGO()

	if headGO then
		if not headGO.transform.position then
			local position = containerGo.transform.position
			local worldPos = Vector3(position.x, position.y, position.z)

			return (RoomBendingHelper.worldToBendingSimple(worldPos))
		end
	end
end

function RoomViewUIFishingStoreItem:getBuildingEntity()
	local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.FishingStore)
	local buildingUid = buildingList and buildingList[1].buildingUid

	return (self._scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding))
end

function RoomViewUIFishingStoreItem:_customOnDestory()
	return
end

return RoomViewUIFishingStoreItem
