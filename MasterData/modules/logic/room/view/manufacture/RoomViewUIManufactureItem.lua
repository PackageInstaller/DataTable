-- chunkname: @modules/logic/room/view/manufacture/RoomViewUIManufactureItem.lua

module("modules.logic.room.view.manufacture.RoomViewUIManufactureItem", package.seeall)

local RoomViewUIManufactureItem = class("RoomViewUIManufactureItem", RoomViewUIBaseItem)

function RoomViewUIManufactureItem:ctor(manufactureType)
	RoomViewUIManufactureItem.super.ctor(self)

	self._manufactureType = manufactureType
end

function RoomViewUIManufactureItem:_customOnInit()
	self._gonone = gohelper.findChild(self._gocontainer, "#go_none")
	self._produceAnimator = self._gonone:GetComponent(RoomEnum.ComponentType.Animator)
	self._golayoutGet = gohelper.findChild(self._gocontainer, "#go_layoutGet")
	self._goget = gohelper.findChild(self._gocontainer, "#go_layoutGet/#go_get")
	self._txtbuildingname = gohelper.findChildText(self._gocontainer, "bottom/txt_buildingName")

	local name = RoomBuildingEnum.BuildingTypeAreName[self._manufactureType]

	self._txtbuildingname.text = luaLang(name)

	gohelper.setActive(self._goget, false)
end

function RoomViewUIManufactureItem:_customAddEventListeners()
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._refreshManufactureItem, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._refreshManufactureItem, self)
	self:refreshUI(true)
end

function RoomViewUIManufactureItem:_customRemoveEventListeners()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._refreshManufactureItem, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._refreshManufactureItem, self)
end

function RoomViewUIManufactureItem:_onClick(go, param)
	if self._canGet then
		ManufactureController.instance:gainCompleteManufactureItem()
	else
		ManufactureController.instance:openManufactureBuildingViewByType(self._manufactureType)
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function RoomViewUIManufactureItem:refreshUI(isInit)
	self:_refreshManufactureItem()
	self:_refreshShow(isInit)
	self:_refreshPosition()
end

function RoomViewUIManufactureItem:_refreshManufactureItem()
	self._canGet = false

	local hasRunningBuilding = false
	local completeManufactureItemList = {}
	local areaMo = RoomMapBuildingAreaModel.instance:getAreaMOByBType(self._manufactureType)
	local buildingMOList = areaMo and areaMo:getBuildingMOList(true)

	if buildingMOList then
		for _, buildingMO in ipairs(buildingMOList) do
			local newerCompleteManufactureItem = buildingMO:getNewerCompleteManufactureItem()
			local manufactureState = buildingMO:getManufactureState()
			local isRunning = manufactureState == RoomManufactureEnum.ManufactureState.Running

			hasRunningBuilding = hasRunningBuilding or isRunning

			if newerCompleteManufactureItem then
				self._canGet = true

				table.insert(completeManufactureItemList, newerCompleteManufactureItem)
			end
		end
	end

	if self._iconList then
		for _, icon in ipairs(self._iconList) do
			icon:UnLoadImage()
		end
	end

	self._iconList = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onsSetManufactureItem, completeManufactureItemList, self._golayoutGet, self._goget)
	gohelper.setActive(self._gonone, not self._canGet)
	gohelper.setActive(self._golayoutGet, self._canGet)
	self._produceAnimator:Play((not self._canGet and hasRunningBuilding or nil) and "loop", 0, 0)
end

function RoomViewUIManufactureItem:_onsSetManufactureItem(obj, data, index)
	local simageIcon = gohelper.findChildSingleImage(obj, "#simage_item")
	local itemId = ManufactureConfig.instance:getItemId(data)
	local _, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, itemId)

	if not string.nilorempty(icon) then
		simageIcon:LoadImage(icon)
	end

	self._iconList[#self._iconList + 1] = simageIcon
end

function RoomViewUIManufactureItem:_refreshShow(isInit)
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

function RoomViewUIManufactureItem:getUI3DPos()
	local buildingUid = RoomMapBuildingAreaModel.instance:getBuildingUidByType(self._manufactureType)
	local buildingEntity = self._scene.buildingmgr:getBuildingEntity(buildingUid, SceneTag.RoomBuilding)

	if not buildingEntity then
		self:_setShow(false, true)

		return Vector3.zero
	end

	local headGO = buildingEntity:getHeadGO()
	local containerGo = buildingEntity.containerGO

	if headGO then
		if not headGO.transform.position then
			local position = containerGo.transform.position
			local worldPos = Vector3(position.x, position.y, position.z)

			return (RoomBendingHelper.worldToBendingSimple(worldPos))
		end
	end
end

function RoomViewUIManufactureItem:_customOnDestory()
	for _, icon in ipairs(self._iconList) do
		icon:UnLoadImage()
	end
end

return RoomViewUIManufactureItem
