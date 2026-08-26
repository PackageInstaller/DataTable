-- chunkname: @modules/logic/room/view/manufacture/RoomViewUITradeBuildingItem.lua

module("modules.logic.room.view.manufacture.RoomViewUITradeBuildingItem", package.seeall)

local RoomViewUITradeBuildingItem = class("RoomViewUITradeBuildingItem", RoomViewUIBaseItem)

function RoomViewUITradeBuildingItem:_customOnInit()
	self._gomain = gohelper.findChild(self._gocontainer, "bubblebg/#go_main")
	self._imagebuildingicon = gohelper.findChildImage(self._gocontainer, "#image_buildingicon")
	self._txtnamecn = gohelper.findChildText(self._gocontainer, "bottom/txt_buildingName")
	self._goreddot = gohelper.findChild(self._gocontainer, "bottom/#go_reddot")
	self._txtnamecn.text = luaLang("room_trade_name")

	UISpriteSetMgr.instance:setCritterSprite(self._imagebuildingicon, "critter_buildingicon_6")
	gohelper.setActive(self._gomain, true)
end

function RoomViewUITradeBuildingItem:_customAddEventListeners()
	self:refreshUI(true)
end

function RoomViewUITradeBuildingItem:_customRemoveEventListeners()
	return
end

function RoomViewUITradeBuildingItem:_onClick(go, param)
	ManufactureController.instance:openRoomTradeView()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function RoomViewUITradeBuildingItem:refreshUI(isInit)
	self:_refreshShow(isInit)
	self:_refreshPosition()
end

function RoomViewUITradeBuildingItem:_refreshShow(isInit)
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

	local isHasBulding = self:getBuildingEntity() ~= nil

	self:_setShow(isHasBulding, isInit)
end

function RoomViewUITradeBuildingItem:getUI3DPos()
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

function RoomViewUITradeBuildingItem:getBuildingEntity()
	local buildingUid
	local buildingList = ManufactureModel.instance:getTradeBuildingListInOrder()

	return (self._scene.buildingmgr:getBuildingEntity((buildingList or nil) and buildingList[1].buildingUid, SceneTag.RoomBuilding))
end

function RoomViewUITradeBuildingItem:_customOnDestory()
	return
end

return RoomViewUITradeBuildingItem
