-- chunkname: @modules/logic/room/view/RoomViewUIInitItem.lua

module("modules.logic.room.view.RoomViewUIInitItem", package.seeall)

local RoomViewUIInitItem = class("RoomViewUIInitItem", RoomViewUIBaseItem)

function RoomViewUIInitItem:ctor()
	RoomViewUIInitItem.super.ctor(self)
end

function RoomViewUIInitItem:_customOnInit()
	self._txtbuildingname = gohelper.findChildText(self._gocontainer, "bottom/txt_buildingName")
	self._goskinreddot = gohelper.findChild(self._gocontainer, "bottom/#go_reddot")
	self._gobubbleContent = gohelper.findChild(self._gocontainer, "#go_bubbleContent")
	self._goawarn = gohelper.findChild(self._gocontainer, "state/#go_warn")
	self._gostop = gohelper.findChild(self._gocontainer, "state/#go_stop")
	self._goadd = gohelper.findChild(self._gocontainer, "state/#go_add")
	self._txtcount = gohelper.findChildText(self._gocontainer, "count/txt_count")
	self._gotxtcount = gohelper.findChild(self._gocontainer, "count")
	self._txtper = gohelper.findChildText(self._gocontainer, "count/txt_count/txt")
	self._simagegathericon = gohelper.findChildSingleImage(self._gocontainer, "simage_gathericon")
	self._simagebuildingicon = gohelper.findChildSingleImage(self._gocontainer, "simage_buildingicon")
	self._goqipaobg = gohelper.findChild(self._gocontainer, "qipao")
	self._goroomgifticon = gohelper.findChild(self._gocontainer, "simage_actroomicon")
	self._goreddot = gohelper.findChild(self._gocontainer, "count/txt_count/go_reddot")
	self._goupgrade = gohelper.findChild(self._gocontainer, "#go_upgrade")
	self._gobg = gohelper.findChild(self._gocontainer, "count/bg")
	self._gobg1 = gohelper.findChild(self._gocontainer, "count/bg1")
	self._customReddotGO = gohelper.findChild(self._gocontainer, "count/txt_count/go_reddot/type1")
	self._bgGO = gohelper.findChild(self._gocontainer, "count/bg")

	gohelper.setActive(self._customReddotGO, false)
	gohelper.setActive(self._bgGO, false)

	self._gobubbleitem = gohelper.findChild(self._gocontainer, "bubbleContent/#go_bubbleitem")

	gohelper.setActive(self._gobubbleitem, false)

	local newSkinReddot = RoomInitBuildingEnum.InitBuildingSkinReddot[RoomInitBuildingEnum.InitBuildingId.Hall]

	if newSkinReddot then
		RedDotController.instance:addRedDot(self._goskinreddot, newSkinReddot)
	end
end

function RoomViewUIInitItem:_customAddEventListeners()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshRelateDot, self)
	RoomMapController.instance:registerCallback(RoomEvent.UpdateRoomLevel, self._refreshUpgradeUI, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.UpdateActInfo, self._refreshBubble, self)
	RoomGiftController.instance:registerCallback(RoomGiftEvent.GetBonus, self._refreshBubble, self)
	self:refreshUI()
	self:_refreshShow(true)
end

function RoomViewUIInitItem:_customRemoveEventListeners()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshRelateDot, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateRoomLevel, self._refreshUpgradeUI, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshActivityState, self._checkActivityInfo, self)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.UpdateActInfo, self._refreshBubble, self)
	RoomGiftController.instance:unregisterCallback(RoomGiftEvent.GetBonus, self._refreshBubble, self)
end

function RoomViewUIInitItem:_refreshRelateDot(dict)
	for id, _ in pairs(dict) do
		if id == RedDotEnum.DotNode.RoomInitBuildingLevel then
			self:_refreshUpgradeUI()

			break
		end
	end
end

function RoomViewUIInitItem:_onDailyRefresh()
	RoomGiftController.instance:getAct159Info()
end

function RoomViewUIInitItem:_checkActivityInfo(actId)
	local isCheckActInfo = true

	if actId and actId ~= 0 then
		local roomGiftActId = RoomGiftModel.instance:getActId()

		isCheckActInfo = actId == roomGiftActId
	end

	if isCheckActInfo then
		RoomGiftController.instance:getAct159Info()
	end
end

function RoomViewUIInitItem:refreshUI()
	gohelper.setActive(self._goawarn, false)
	gohelper.setActive(self._gostop, false)
	gohelper.setActive(self._gobg, false)
	gohelper.setActive(self._gobg1, false)
	gohelper.setActive(self._simagegathericon.gameObject, false)

	self._txtcount.text = ""
	self._txtper.text = ""

	self._simagebuildingicon:LoadImage(ResUrl.getRoomImage("productline/icon_1"))

	self._txtbuildingname.text = luaLang("room_initbuilding_title")

	self:_refreshPosition()
	self:_refreshUpgradeUI()
	self:_refreshBubble()
end

function RoomViewUIInitItem:_refreshUpgradeUI()
	local canLevelUp, errorCode = RoomInitBuildingHelper.canLevelUp()

	gohelper.setActive(self._goupgrade, canLevelUp)
end

function RoomViewUIInitItem:_refreshShow(isInit)
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

function RoomViewUIInitItem:getUI3DPos()
	local initBuildingGO = self._scene.buildingmgr:getInitBuildingGO()
	local px = 0
	local pz = 0

	if not gohelper.isNil(initBuildingGO) then
		local position = RoomBuildingHelper.getCenterPosition(initBuildingGO)

		px = position.x
		pz = position.z
	end

	local worldPos = Vector3(px, 0.5, px)

	return (RoomBendingHelper.worldToBendingSimple(worldPos))
end

function RoomViewUIInitItem:_onGuideTouchUIPart(partId)
	if tonumber(partId) == self._partId then
		self:_onClick()
	end
end

function RoomViewUIInitItem:_refreshBubble()
	local canGetRoomGift = RoomGiftModel.instance:isCanGetBonus()

	gohelper.setActive(self._goroomgifticon, canGetRoomGift)
	gohelper.setActive(self._simagebuildingicon.gameObject, not canGetRoomGift)
	gohelper.setActive(self._goqipaobg, not canGetRoomGift)
end

function RoomViewUIInitItem:_onClick(go, param)
	local canGetRoomGift = RoomGiftModel.instance:isCanGetBonus()

	if canGetRoomGift then
		RoomGiftController.instance:getAct159Bonus()
	else
		RoomMapController.instance:openRoomInitBuildingView(0.2)
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
end

function RoomViewUIInitItem:_customOnDestory()
	if self._simagegathericon then
		self._simagegathericon:UnLoadImage()

		self._simagegathericon = nil
	end

	if self._simagebuildingicon then
		self._simagebuildingicon:UnLoadImage()

		self._simagebuildingicon = nil
	end
end

return RoomViewUIInitItem
