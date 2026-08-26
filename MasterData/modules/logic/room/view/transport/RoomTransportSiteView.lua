-- chunkname: @modules/logic/room/view/transport/RoomTransportSiteView.lua

module("modules.logic.room.view.transport.RoomTransportSiteView", package.seeall)

local RoomTransportSiteView = class("RoomTransportSiteView", BaseView)

function RoomTransportSiteView:onInitView()
	self._btnmaskable = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_maskable")
	self._goBackBtns = gohelper.findChild(self.viewGO, "go_content/#go_BackBtns")
	self._goleft = gohelper.findChild(self.viewGO, "go_content/#go_left")
	self._golayoutSwitchBtns = gohelper.findChild(self.viewGO, "go_content/#go_left/#go_layoutSwitchBtns")
	self._gositesitem = gohelper.findChild(self.viewGO, "go_content/#go_left/#go_layoutSwitchBtns/#go_sitesitem")
	self._gocritterInfoItem = gohelper.findChild(self.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem")
	self._gohascritter = gohelper.findChild(self.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_hascritter")
	self._gocritterIcon = gohelper.findChild(self.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_hascritter/#go_critterIcon")
	self._gonocritter = gohelper.findChild(self.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_nocritter")
	self._gocritterselected = gohelper.findChild(self.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_critterselected")
	self._btncritterclick = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#btn_critterclick")
	self._goright = gohelper.findChild(self.viewGO, "go_content/#go_right")
	self._btnhideui = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_right/#btn_hideui")
	self._gobuildinginfo = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_buildinginfo")
	self._gohasBuilding = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding")
	self._imagebuildingrare = gohelper.findChildImage(self.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#image_buildingrare")
	self._simagebuildingicon = gohelper.findChildSingleImage(self.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#simage_buildingicon")
	self._txtbuildingname = gohelper.findChildText(self.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#txt_buildingname")
	self._txtbuildingbase = gohelper.findChildText(self.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#txt_buildingbase")
	self._gonobuilding = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_buildinginfo/#go_nobuilding")
	self._btnbuilding = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_right/#go_buildinginfo/#btn_building")
	self._btncamerastate = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_right/#btn_camerastate")
	self._gofirstperson = gohelper.findChild(self.viewGO, "go_content/#go_right/#btn_camerastate/#go_firstperson")
	self._gothirdperson = gohelper.findChild(self.viewGO, "go_content/#go_right/#btn_camerastate/#go_thirdperson")
	self._gobuildinglist = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_buildinglist")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "go_content/#go_right/#go_buildinglist/#simage_rightbg")
	self._scrollbuilding = gohelper.findChildScrollRect(self.viewGO, "go_content/#go_right/#go_buildinglist/#scroll_building")
	self._scrollbuildingskin = gohelper.findChildScrollRect(self.viewGO, "go_content/#go_right/#go_buildinglist/#scroll_buildingskin")
	self._btnbuildingconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_right/#go_buildinglist/#btn_buildingconfirm")
	self._btncloseBuilding = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_right/#go_buildinglist/#btn_closeBuilding")
	self._gocritterlist = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_critterlist")
	self._btnmood = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_mood")
	self._gomoodnormal = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_mood/#go_moodnormal")
	self._gomoodselected = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_mood/#go_moodselected")
	self._btnrare = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_rare")
	self._goratenormal = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_rare/#go_ratenormal")
	self._gorateselected = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_rare/#go_rateselected")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_filter")
	self._gonotfilter = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_filter/#go_notfilter")
	self._gofilter = gohelper.findChild(self.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_filter/#go_filter")
	self._scrollcritter = gohelper.findChildScrollRect(self.viewGO, "go_content/#go_right/#go_critterlist/#scroll_critter")
	self._btncloseCritter = gohelper.findChildButtonWithAudio(self.viewGO, "go_content/#go_right/#go_critterlist/#btn_closeCritter")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTransportSiteView:addEvents()
	self._btnmaskable:AddClickListener(self._btnmaskableOnClick, self)
	self._btncritterclick:AddClickListener(self._btncritterclickOnClick, self)
	self._btnhideui:AddClickListener(self._btnhideuiOnClick, self)
	self._btnbuilding:AddClickListener(self._btnbuildingOnClick, self)
	self._btncamerastate:AddClickListener(self._btncamerastateOnClick, self)
	self._btnbuildingconfirm:AddClickListener(self._btnbuildingconfirmOnClick, self)
	self._btncloseBuilding:AddClickListener(self._btncloseBuildingOnClick, self)
	self._btnmood:AddClickListener(self._btnmoodOnClick, self)
	self._btnrare:AddClickListener(self._btnrareOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btncloseCritter:AddClickListener(self._btncloseCritterOnClick, self)
end

function RoomTransportSiteView:removeEvents()
	self._btnmaskable:RemoveClickListener()
	self._btncritterclick:RemoveClickListener()
	self._btnhideui:RemoveClickListener()
	self._btnbuilding:RemoveClickListener()
	self._btncamerastate:RemoveClickListener()
	self._btnbuildingconfirm:RemoveClickListener()
	self._btncloseBuilding:RemoveClickListener()
	self._btnmood:RemoveClickListener()
	self._btnrare:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
	self._btncloseCritter:RemoveClickListener()
end

function RoomTransportSiteView:_btncloseBuildingOnClick()
	self:_setRightTabId(self._RightTabId.BuildingInfo)
end

function RoomTransportSiteView:_btnmoodOnClick()
	return
end

function RoomTransportSiteView:_btnrareOnClick()
	return
end

function RoomTransportSiteView:_btnfilterOnClick()
	return
end

function RoomTransportSiteView:_btncamerastateOnClick()
	self._isFirstPerson = self._isFirstPerson ~= true

	RoomTransportController.instance:tweenCameraFocusSite(self._selectSiteType, self._isFirstPerson)
	self:_refreshCameraStateUI()

	local pathMO = self:getPathMOBySiteType(self._selectSiteType)

	RoomStatController.instance:roomTransportCameraSwitch(self._isFirstPerson, pathMO, pathMO)
end

function RoomTransportSiteView:_btnmaskableOnClick()
	if not self._curUIIsShow then
		self:_setUIShow(true)

		return
	end
end

function RoomTransportSiteView:_btnswithItemOnClick()
	return
end

function RoomTransportSiteView:_btnbuildingconfirmOnClick()
	local buildingMO = RoomTransportBuildingListModel.instance:getSelectMO()
	local pathMO = self:getPathMOBySiteType(self._selectSiteType)
	local builingSkinMO = RoomTransportBuildingSkinListModel.instance:getSelectMO()

	if pathMO and buildingMO then
		pathMO.buildingUid = buildingMO.id
		pathMO.buildingId = buildingMO.buildingId

		if builingSkinMO then
			if not builingSkinMO.id then
				local skinId = 0

				pathMO.buildingSkinId = skinId

				RoomRpc.instance:sendAllotVehicleRequest(pathMO.id, buildingMO.id, skinId)

				self._waitReplyRightTabId = self._RightTabId.BuildingInfo
			end
		end
	else
		self:_setRightTabId(self._RightTabId.BuildingInfo)
	end
end

function RoomTransportSiteView:_btnhideuiOnClick()
	self:_setUIShow(false)
end

function RoomTransportSiteView:_btnbuildingOnClick()
	self:_setRightTabId(self._RightTabId.BuildingList)

	local pathMO = self:getPathMOBySiteType(self._selectSiteType)

	if pathMO then
		self:_setBuildingSelect(pathMO.buildingId, pathMO.buildingSkinId)
		RoomTransportBuildingListModel.instance:setSelect(pathMO.buildingUid)
	end
end

function RoomTransportSiteView:_btncritterclickOnClick()
	local pathMO = self:getPathMOBySiteType(self._selectSiteType)

	if pathMO then
		ManufactureController.instance:clickTransportCritterSlotItem(pathMO.id)
	end
end

function RoomTransportSiteView:_btncloseCritterOnClick()
	self:_setRightTabId(self._RightTabId.BuildingInfo)
end

function RoomTransportSiteView:_editableInitView()
	gohelper.setActive(self._gocritterselected, false)

	self._goAddAnim = gohelper.findChild(self._gohascritter, "#add")
	self._gocontent = gohelper.findChild(self.viewGO, "go_content")
	self._RightTabId = {
		CritterList = 2,
		BuildingInfo = 3,
		BuildingList = 1
	}

	self:_setRightTabId(self._RightTabId.BuildingInfo)
	self:_initSiteItemList()
end

function RoomTransportSiteView:onUpdateParam()
	return
end

function RoomTransportSiteView:onOpen()
	RoomStatController.instance:startOpenTransportSiteView()

	self._selectSiteType = self.viewParam.siteType

	local pathMO = self:getPathMOBySiteType(self._selectSiteType)

	if pathMO then
		self._addAnimCritterUid = pathMO.critterUid or 0
	end

	self._isFirstPerson = false

	if self.viewContainer then
		self.addEventCb(self, self.viewContainer, RoomEvent.TransportSiteSelect, self._onSelectSiteItem, self)
		self.addEventCb(self, self.viewContainer, RoomEvent.TransportCritterSelect, self._onSelectCritterItem, self)
		self.addEventCb(self, self.viewContainer, RoomEvent.TransportBuildingSelect, self._onSelectBuildingItem, self)
		self.addEventCb(self, self.viewContainer, RoomEvent.TransportBuildingSkinSelect, self._onSelectBuildingSkinItem, self)
	end

	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportCritterChanged, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.TransportBuildingChanged, self._refreshUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.ShowUI, self._onShowUI, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.HideUI, self._onHideUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onOpenCloseView, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.NewBuildingPush, self._newBuildingPush, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshSkinList, self)
	RoomTransportCritterListModel.instance:setCritterList()
	RoomTransportBuildingListModel.instance:setBuildingList()
	self:_refreshUI()
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportSiteViewShowChanged)
end

function RoomTransportSiteView:onClose()
	local pathMO = self:getPathMOBySiteType(self._selectSiteType)
	local scene = RoomCameraController.instance:getRoomScene()

	RoomCameraController.instance:resetCameraStateByKey(ViewName.RoomTransportSiteView)

	if scene then
		scene.cameraFollow:setFollowTarget(nil)
	end

	RoomStatController.instance:closeTransportSiteView(pathMO)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportSiteViewShowChanged)
end

function RoomTransportSiteView:onDestroyView()
	return
end

function RoomTransportSiteView:_onShowUI()
	self:_setUIShow(true)
end

function RoomTransportSiteView:_onHideUI()
	self:_setUIShow(false)
end

function RoomTransportSiteView:_onOpenCloseView(viewName)
	gohelper.setActive(self._gocritterselected, ViewMgr.instance:isOpen(ViewName.RoomCritterListView))
end

function RoomTransportSiteView:_setUIShow(isShow)
	self._curUIIsShow = isShow

	gohelper.setActive(self._gocontent, isShow)
end

function RoomTransportSiteView:_newBuildingPush()
	RoomTransportBuildingListModel.instance:setBuildingList()
end

function RoomTransportSiteView:_refreshSkinList()
	local buildingUid = RoomTransportBuildingListModel.instance:getSelect()

	RoomTransportBuildingSkinListModel.instance:setBuildingUid(buildingUid)
end

function RoomTransportSiteView:_refreshUI()
	self:_refreshCritterUI()
	self:_refreshBuildingUI()
	self:_applyReplyRightTabId()
	self:_refreshCameraStateUI()
	self:_refreshSiteItemUI()
end

function RoomTransportSiteView:_applyReplyRightTabId()
	if self._waitReplyRightTabId then
		self:_setRightTabId(self._waitReplyRightTabId)
	end
end

function RoomTransportSiteView:_refreshCameraStateUI()
	gohelper.setActive(self._gofirstperson, not self._isFirstPerson)
	gohelper.setActive(self._gothirdperson, self._isFirstPerson)
end

function RoomTransportSiteView:_refreshCritterUI()
	local pathMO = self:getPathMOBySiteType(self._selectSiteType)
	local critterMO

	if pathMO then
		critterMO = CritterModel.instance:getCritterMOByUid(pathMO.critterUid)
	end

	local hasCritter = critterMO ~= nil

	if hasCritter then
		self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocritterIcon)

		self.critterIcon:setMOValue(critterMO:getId(), critterMO:getDefineId())
		self.critterIcon:showMood()
	end

	gohelper.setActive(self._gohascritter, hasCritter)
	gohelper.setActive(self._gonocritter, not hasCritter)

	if pathMO then
		if not pathMO.critterUid then
			local critterUid = 0

			if self._addAnimCritterUid ~= critterUid then
				self._addAnimCritterUid = critterUid

				if hasCritter then
					gohelper.setActive(self._goAddAnim, false)
				end
			end

			gohelper.setActive(self._goAddAnim, hasCritter)
		end
	end
end

function RoomTransportSiteView:_refreshBuildingUI()
	local pathMO = self:getPathMOBySiteType(self._selectSiteType)
	local buildingCfg

	if pathMO then
		buildingCfg = RoomConfig.instance:getBuildingConfig(pathMO.buildingId)
	end

	local hasBuiling = buildingCfg ~= nil

	gohelper.setActive(self._gohasBuilding, hasBuiling)
	gohelper.setActive(self._gonobuilding, not hasBuiling)

	if buildingCfg then
		self._simagebuildingicon:LoadImage(ResUrl.getRoomImage("building/" .. buildingCfg.icon))

		if not RoomBuildingEnum.RareFrame[buildingCfg.rare] then
			UISpriteSetMgr.instance:setRoomSprite(self._imagebuildingrare, RoomBuildingEnum.RareFrame[buildingCfg.rare])

			self._txtbuildingname.text = buildingCfg.name
			self._txtbuildingbase.text = buildingCfg.useDesc
		end
	end

	self.viewContainer:setUseBuildingUid(pathMO and pathMO.buildingUid)
end

function RoomTransportSiteView:_setRightTabId(tabId)
	self._waitReplyRightTabId = nil

	if self._lastRightTabId ~= tabId then
		self._lastRightTabId = tabId

		gohelper.setActive(self._gobuildinginfo, tabId == self._RightTabId.BuildingInfo)
		gohelper.setActive(self._gobuildinglist, tabId == self._RightTabId.BuildingList)
		gohelper.setActive(self._gocritterlist, tabId == self._RightTabId.CritterList)
	end
end

function RoomTransportSiteView:_onSelectSiteItem(dataMO)
	if not dataMO or dataMO.buildingType == self._selectSiteType then
		return
	end

	local lastPathMO = self:getPathMOBySiteType(self._selectSiteType)

	self._selectSiteType = dataMO.buildingType

	local newPathMO = self:getPathMOBySiteType(self._selectSiteType)

	if newPathMO then
		self._addAnimCritterUid = newPathMO.critterUid or 0
	end

	RoomTransportController.instance:tweenCameraFocusSite(self._selectSiteType, self._isFirstPerson)
	self:_refreshUI()
	RoomStatController.instance:roomTransportCameraSwitch(self._isFirstPerson, lastPathMO, newPathMO)

	if ViewMgr.instance:isOpen(ViewName.RoomCritterListView) then
		ViewMgr.instance:closeView(ViewName.RoomCritterListView)
	end
end

function RoomTransportSiteView:_onSelectCritterItem(critterMO)
	if not critterMO then
		return
	end

	local pathMO = self:getPathMOBySiteType(self._selectSiteType)

	RoomRpc.instance:sendAllotCritterRequestt(pathMO.id, critterMO.id)

	self._waitReplyRightTabId = self._RightTabId.BuildingInfo
end

function RoomTransportSiteView:_onSelectBuildingItem(dataMO)
	if dataMO.isNeedToBuy then
		if RoomBuildingEnum.TransportBuyTosatDic[dataMO.buildingId] then
			GameFacade.showToast(RoomBuildingEnum.TransportBuyTosatDic[dataMO.buildingId])

			return
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTransportBuildingSkinShopBuy, MsgBoxEnum.BoxType.Yes_No, self._yseGoToShop, nil, nil, self, nil, nil)

		return
	end

	RoomTransportBuildingListModel.instance:setSelect(dataMO.id)

	local pathMO = self:getPathMOByBuildingUid(dataMO.id)
	local skinId = 0

	skinId = pathMO and RoomTransportBuildingSkinListModel.instance:getById(pathMO.buildingSkinId) and pathMO.buildingSkinId or skinId

	self:_setBuildingSelect(dataMO.buildingId, skinId)
end

function RoomTransportSiteView:_setBuildingSelect(buildingId, skinId)
	RoomTransportBuildingSkinListModel.instance:setBuildingId(buildingId)

	local count = RoomTransportBuildingSkinListModel.instance:getCount()

	gohelper.setActive(self._scrollbuildingskin, count > 0)

	local skinMO = RoomTransportBuildingSkinListModel.instance:getById(skinId)

	RoomTransportBuildingSkinListModel.instance:setSelect(skinMO.id or 0)
end

function RoomTransportSiteView:_onSelectBuildingSkinItem(skinMO)
	if skinMO and not skinMO.isLock then
		RoomTransportBuildingSkinListModel.instance:setSelect(skinMO.id)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTransportBuildingSkinShopBuy, MsgBoxEnum.BoxType.Yes_No, self._yseGoToShop, nil, nil, self, nil, nil)
	end
end

function RoomTransportSiteView:_yseGoToShop()
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function RoomTransportSiteView:_initSiteItemList()
	self._dataList = self:getPathDataList()
	self._siteItemCompList = {}

	local parent_obj = self._golayoutSwitchBtns
	local model_obj = self._gositesitem

	gohelper.CreateObjList(self, self._siteItemShow, self._dataList, parent_obj, model_obj, RoomTransportSiteItem)
end

function RoomTransportSiteView:_siteItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)

	cell_component._view = cell_component._view or self

	table.insert(self._siteItemCompList, cell_component)
end

function RoomTransportSiteView:_refreshSiteItemUI()
	if self._siteItemCompList then
		for _, itemComp in ipairs(self._siteItemCompList) do
			local dataMO = itemComp:getDataMO()

			itemComp:onSelect(dataMO and dataMO.buildingType == self._selectSiteType)
			itemComp:refreshUI()
		end
	end
end

function RoomTransportSiteView:getPathMOBySiteType(siteType)
	local fromType, toType = RoomTransportHelper.getSiteFromToByType(siteType)

	return RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(fromType, toType)
end

function RoomTransportSiteView:getPathMOByBuildingUid(buildingUid)
	local moList = RoomMapTransportPathModel.instance:getTransportPathMOList()

	for i = 1, #moList do
		local pathMO = moList[i]

		if pathMO and pathMO.buildingUid == buildingUid then
			return pathMO
		end
	end
end

function RoomTransportSiteView:getPathDataList()
	local typesList = RoomTransportHelper.getPathBuildingTypesList()
	local moList = {}

	for _, types in ipairs(typesList) do
		local fromType = types[1]
		local toType = types[2]
		local pathMO = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(fromType, toType)

		if pathMO then
			local data = {
				buildingType = fromType,
				fromType = fromType,
				toType = toType,
				pathId = pathMO.id
			}

			table.insert(moList, data)
		end
	end

	return moList
end

return RoomTransportSiteView
