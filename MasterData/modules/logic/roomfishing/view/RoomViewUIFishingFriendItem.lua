-- chunkname: @modules/logic/roomfishing/view/RoomViewUIFishingFriendItem.lua

module("modules.logic.roomfishing.view.RoomViewUIFishingFriendItem", package.seeall)

local RoomViewUIFishingFriendItem = class("RoomViewUIFishingFriendItem", RoomViewUIBaseItem)

function RoomViewUIFishingFriendItem:ctor(friendUserId)
	RoomViewUIFishingFriendItem.super.ctor(self)

	self._userId = friendUserId
end

function RoomViewUIFishingFriendItem:_customOnInit()
	self._goheadicon = gohelper.findChild(self._gocontainer, "#go_headicon")
	self._playericon = IconMgr.instance:getCommonPlayerIcon(self._goheadicon)
	self._txtPlayerName = gohelper.findChildText(self._gocontainer, "#txt_PlayerName")

	local name, portrait = FishingModel.instance:getFishingFriendInfo(self._userId)

	self._playericon:setMOValue(self._userId, "", 0, portrait)
	self._playericon:setShowLevel(false)
	self._playericon:setEnableClick(false)

	self._txtPlayerName.text = name
end

function RoomViewUIFishingFriendItem:_customAddEventListeners()
	self:refreshUI(true)
end

function RoomViewUIFishingFriendItem:_customRemoveEventListeners()
	return
end

function RoomViewUIFishingFriendItem:getUI3DPos()
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

function RoomViewUIFishingFriendItem:_onClick(go, param)
	return
end

function RoomViewUIFishingFriendItem:refreshUI(isInit)
	self:_refreshShow(isInit)
	self:_refreshPosition()
end

function RoomViewUIFishingFriendItem:_refreshShow(isInit)
	local cameraState = self._scene.camera:getCameraState()

	if cameraState ~= RoomEnum.CameraState.Overlook and cameraState ~= RoomEnum.CameraState.OverlookAll then
		self:_setShow(false, isInit)

		return
	end

	local hasBuilding = self:getBuildingEntity() ~= nil

	self:_setShow(hasBuilding, isInit)
end

function RoomViewUIFishingFriendItem:getBuildingEntity()
	local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Fishing)

	if buildingList then
		for _, buildingMO in ipairs(buildingList) do
			local belongUserId = buildingMO:getBelongUserId()

			if belongUserId and belongUserId == self._userId then
				return (self._scene.buildingmgr:getBuildingEntity(buildingMO.buildingUid, SceneTag.RoomBuilding))
			end
		end
	end
end

function RoomViewUIFishingFriendItem:_customOnDestory()
	return
end

RoomViewUIFishingFriendItem.prefabPath = "ui/viewres/room/fish/roomfishfriendui.prefab"

return RoomViewUIFishingFriendItem
