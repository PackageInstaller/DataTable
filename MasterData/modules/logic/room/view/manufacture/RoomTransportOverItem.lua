-- chunkname: @modules/logic/room/view/manufacture/RoomTransportOverItem.lua

module("modules.logic.room.view.manufacture.RoomTransportOverItem", package.seeall)

local RoomTransportOverItem = class("RoomTransportOverItem", LuaCompBase)

function RoomTransportOverItem:init(go)
	self.go = go

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportOverItem:_editableInitView()
	self._gounlink = gohelper.findChild(self.go, "unlink")
	self._golinked = gohelper.findChild(self.go, "linked")
	self._btngoto = gohelper.findChildClickWithAudio(self.go, "linked/#btn_goto/clickarea")
	self._gocritterInfoItem = gohelper.findChild(self.go, "linked/critterInfo/#go_critterInfoItem")
	self._txtto = gohelper.findChildText(self.go, "linked/transportInfo/info/#txt_to")
	self._txtfrom = gohelper.findChildText(self.go, "linked/transportInfo/info/#txt_from")
	self._gopause = gohelper.findChild(self.go, "linked/transportInfo/info/pause")
	self._gotransporting = gohelper.findChild(self.go, "linked/transportInfo/info/transporting")
	self._simagevehicle = gohelper.findChildSingleImage(self.go, "linked/transportInfo/vehicle/#simage_vehicle")
	self._govehicleimg = self._simagevehicle.gameObject
	self._txtvehicle = gohelper.findChildText(self.go, "linked/transportInfo/vehicle/#txt_vehicle")
	self._txtway = gohelper.findChildText(self.go, "linked/transportInfo/vehicle/#txt_vehicle/#txt_way")

	self:clearVar()
end

function RoomTransportOverItem:addEventListeners()
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportCritterChanged, self._onCritterChanged, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportBuildingChanged, self._onVehicleChange, self)
end

function RoomTransportOverItem:removeEventListeners()
	self._btngoto:RemoveClickListener()
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.TransportCritterChanged, self._onCritterChanged, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.TransportBuildingChanged, self._onVehicleChange, self)
end

function RoomTransportOverItem:_btngotoOnClick()
	if self.transportPathMO then
		ViewMgr.instance:closeView(ViewName.RoomOverView, true)

		local siteType = RoomTransportHelper.fromTo2SiteType(self.transportPathMO.fromType, self.transportPathMO.toType)

		RoomTransportController.instance:openTransportSiteView(siteType, RoomEnum.CameraState.Overlook)

		local isOpenCritterBuildingView = ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)

		if isOpenCritterBuildingView then
			ManufactureController.instance:closeCritterBuildingView(true)
		end
	end
end

function RoomTransportOverItem:onManufactureInfoUpdate()
	self:checkIsTransporting()
end

function RoomTransportOverItem:_onCritterChanged()
	self:refreshCritterItem()
	self:checkHasMood()
end

function RoomTransportOverItem:_onVehicleChange(l)
	self:refreshInfo()
	self:checkIsTransporting()
end

function RoomTransportOverItem:setData(transportPathMO)
	self.transportPathMO = transportPathMO

	self:checkHasMood()
	self:refresh()
end

function RoomTransportOverItem:refresh()
	self:refreshInfo()
	self:refreshCritterItem()
	self:checkIsTransporting()
end

function RoomTransportOverItem:refreshInfo()
	local buildingCfg
	local hasBuilding = false
	local from = ""
	local to = ""

	if self.transportPathMO then
		buildingCfg = RoomConfig.instance:getBuildingConfig(self.transportPathMO.buildingId)
		hasBuilding = not not buildingCfg

		local fromName = RoomBuildingEnum.BuildingTypeAreName[self.transportPathMO.fromType]
		local toName = RoomBuildingEnum.BuildingTypeAreName[self.transportPathMO.toType]

		from = luaLang(fromName)
		to = luaLang(toName)
	end

	self._txtfrom.text = from
	self._txtto.text = to

	local vehicleName = ""
	local vehicleDesc = ""

	if hasBuilding then
		vehicleName = buildingCfg.name
		vehicleDesc = buildingCfg.useDesc

		local vehicleIcon = ResUrl.getRoomImage("building/" .. buildingCfg.icon)

		self._simagevehicle:LoadImage(vehicleIcon)
	end

	self._txtvehicle.text = vehicleName
	self._txtway.text = vehicleDesc

	gohelper.setActive(self._govehicleimg, hasBuilding)
end

function RoomTransportOverItem:refreshCritterItem()
	self.critterInfoItem = self.critterInfoItem or MonoHelper.addNoUpdateLuaComOnceToGo(self._gocritterInfoItem, RoomTransportCritterInfo)

	local pathId, critterUid

	if self.transportPathMO then
		pathId = self.transportPathMO.id

		local curCritterUid = self.transportPathMO.critterUid

		if curCritterUid ~= tonumber(CritterEnum.InvalidCritterUid) and curCritterUid ~= CritterEnum.InvalidCritterUid then
			critterUid = curCritterUid
		end
	end

	self.critterInfoItem:setData(critterUid, pathId)
end

function RoomTransportOverItem:checkHasMood()
	local critterMood = 0

	if self.transportPathMO then
		local critterMO = CritterModel.instance:getCritterMOByUid(self.transportPathMO.critterUid)

		if critterMO then
			critterMood = critterMO:getMoodValue()
		end
	end

	self.hasMood = critterMood > 0

	self:checkIsTransporting()
end

function RoomTransportOverItem:checkIsTransporting()
	self.isTransporting = false

	local isLink = not not self.transportPathMO

	gohelper.setActive(self._golinked, isLink)
	gohelper.setActive(self._gounlink, not isLink)

	if isLink then
		self.isTransporting = self.transportPathMO:isTransporting()
	end

	gohelper.setActive(self._gotransporting, self.isTransporting)
	gohelper.setActive(self._gopause, not self.isTransporting)
end

function RoomTransportOverItem:everySecondCall()
	if self.hasMood and self.isTransporting then
		self:checkHasMood()
	end
end

function RoomTransportOverItem:clearVar()
	self.hasMood = false
	self.isTransporting = false

	self._simagevehicle:UnLoadImage()
end

function RoomTransportOverItem:onDestroy()
	self:clearVar()
end

return RoomTransportOverItem
