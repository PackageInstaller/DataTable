-- chunkname: @modules/logic/room/view/transport/RoomViewUITransportSiteItem.lua

module("modules.logic.room.view.transport.RoomViewUITransportSiteItem", package.seeall)

local RoomViewUITransportSiteItem = class("RoomViewUITransportSiteItem", RoomViewUIBaseItem)

function RoomViewUITransportSiteItem:ctor(siteType)
	RoomViewUITransportSiteItem.super.ctor(self)

	self._siteType = siteType
	self._fromType, self._toType = RoomTransportHelper.getSiteFromToByType(siteType)
end

function RoomViewUITransportSiteItem:_customOnInit()
	self._gomain = gohelper.findChild(self._gocontainer, "bubblebg/#go_main")
	self._imagebuildingicon = gohelper.findChildImage(self._gocontainer, "#image_buildingicon")
	self._txtbuildingname = gohelper.findChildText(self._gocontainer, "bottom/txt_buildingName")
	self._goreddot = gohelper.findChild(self._gocontainer, "bottom/#go_reddot")
	self._txtbuildingname.text = luaLang(RoomBuildingEnum.BuildingTypeSiteLangKey[self._siteType])
end

function RoomViewUITransportSiteItem:_customAddEventListeners()
	RoomMapController.instance:registerCallback(RoomEvent.TransportBuildingChanged, self._refreshIconUI, self)
	RoomMapController.instance:registerCallback(RoomEvent.TransportCritterChanged, self._refreshIconUI, self)
	self:refreshUI(true)
	self:_refreshIconUI()
end

function RoomViewUITransportSiteItem:_customRemoveEventListeners()
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportBuildingChanged, self._refreshIconUI, self)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportCritterChanged, self._refreshIconUI, self)
end

function RoomViewUITransportSiteItem:_onClick(go, param)
	RoomTransportController.instance:openTransportSiteView(self._siteType)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function RoomViewUITransportSiteItem:_refreshIconUI()
	local pathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(self._fromType, self._toType)
	local vehicleCfg

	if pathMO then
		vehicleCfg = RoomTransportHelper.getVehicleCfgByBuildingId(pathMO.buildingId, pathMO.buildingSkinId)

		if vehicleCfg then
			UISpriteSetMgr.instance:setCritterSprite(self._imagebuildingicon, vehicleCfg.uiIcon)
		end
	end

	gohelper.setActive(self._gomain, (pathMO ~= nil or nil) and pathMO.critterUid and pathMO.critterUid ~= 0)
	gohelper.setActive(self._imagebuildingicon, vehicleCfg ~= nil)
end

function RoomViewUITransportSiteItem:refreshUI(isInit)
	self:_refreshShow(isInit)
	self:_refreshPosition()
end

function RoomViewUITransportSiteItem:_refreshShow(isInit)
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

function RoomViewUITransportSiteItem:getUI3DPos()
	local siteEntity = self._scene.sitemgr:getSiteEntity(self._siteType)

	if not siteEntity then
		return Vector3.zero
	end

	local centerGO = siteEntity:getHeadGO()

	if centerGO then
		return centerGO.transform.position
	end

	return siteEntity.goTrs.position
end

function RoomViewUITransportSiteItem:_customOnDestory()
	return
end

RoomViewUITransportSiteItem.prefabPath = "ui/viewres/room/sceneui/roomscenetransportsiteui.prefab"

return RoomViewUITransportSiteItem
