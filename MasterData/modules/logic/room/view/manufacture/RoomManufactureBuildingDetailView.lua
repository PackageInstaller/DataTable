-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureBuildingDetailView.lua

module("modules.logic.room.view.manufacture.RoomManufactureBuildingDetailView", package.seeall)

local RoomManufactureBuildingDetailView = class("RoomManufactureBuildingDetailView", BaseView)

function RoomManufactureBuildingDetailView:onInitView()
	self._btnclosFull = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closFull")
	self._gocontent = gohelper.findChild(self.viewGO, "root/#go_content")
	self._imagebuildingIcon = gohelper.findChildImage(self.viewGO, "root/#go_content/#image_buildingIcon")
	self._txtbuildingName = gohelper.findChildText(self.viewGO, "root/#go_content/#txt_buildingName")
	self._scrollbase = gohelper.findChildScrollRect(self.viewGO, "root/#go_content/#scroll_base")
	self._gobaseLayer = gohelper.findChild(self.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer")
	self._gobaseitem = gohelper.findChild(self.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem")
	self._txtname = gohelper.findChildText(self.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name/#image_icon")
	self._txtratio = gohelper.findChildText(self.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_ratio")
	self._goitemLayer = gohelper.findChild(self.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_itemLayer")
	self._goitem = gohelper.findChild(self.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_itemLayer/#go_item")
	self._gocritterLayer = gohelper.findChild(self.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_critterLayer")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_content/#btn_close")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureBuildingDetailView:addEvents()
	self._btnclosFull:AddClickListener(self._btnclosFullOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RoomManufactureBuildingDetailView:removeEvents()
	self._btnclosFull:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function RoomManufactureBuildingDetailView:_btnclosFullOnClick()
	self:closeThis()
end

function RoomManufactureBuildingDetailView:_btncloseOnClick()
	self:closeThis()
end

function RoomManufactureBuildingDetailView:_editableInitView()
	self._baseAttrTypeList = {
		CritterEnum.AttributeType.Efficiency,
		CritterEnum.AttributeType.Lucky
	}
	self._attrItemCompList = {}
	self._critterDetailCompList = {}
	self._itemTbList = {}

	gohelper.setActive(self._gobaseitem, false)
	gohelper.setActive(self._goitem, false)

	self._animator = self.viewGO:GetComponent(RoomEnum.ComponentType.Animator)
	self._goroot = gohelper.findChild(self.viewGO, "root")
end

function RoomManufactureBuildingDetailView:onUpdateParam()
	self:_updateParam()
	self:_refreshUI()
end

function RoomManufactureBuildingDetailView:onOpen()
	if self.viewParam then
		self.addEventCb(self, CritterController.instance, CritterEvent.CritterUpdateAttrPreview, self._onAttrPreviewUpdate, self)
		self:_updateParam()
		self:_refreshUI()

		if self._builidngCfg and self._critterUidList and #self._critterUidList > 0 then
			CritterRpc.instance:sendGetRealCritterAttributeRequest(self._builidngCfg.id, self._critterUidList, false)
		end

		if self._animator then
			self._animator:Play(self.viewParam and "open_right" or "open_left")
		end

		if ViewMgr.instance:isOpen(ViewName.RoomOverView) then
			local contentTrs = self._goroot.transform
			local viewHight = recthelper.getHeight(self.viewGO.transform)

			recthelper.setHeight(contentTrs, viewHight)
			recthelper.setAnchor(contentTrs, 0, 0)
		end
	end
end

function RoomManufactureBuildingDetailView:onClose()
	ManufactureController.instance:dispatchEvent(ManufactureEvent.OnCloseManufactureBuildingDetailView)
end

function RoomManufactureBuildingDetailView:onDestroyView()
	for i = 1, #self._attrItemCompList do
		self._attrItemCompList[i]:onDestroy()
	end

	for i = 1, #self._critterDetailCompList do
		self._critterDetailCompList[i]:onDestroy()
	end
end

function RoomManufactureBuildingDetailView:_onAttrPreviewUpdate(critterUidDict)
	local isRefresh = false

	for _, critterMO in ipairs(self._critterMOList) do
		local critterUid = critterMO.id

		if critterUid and critterUidDict[critterUid] then
			isRefresh = true

			break
		end
	end

	if isRefresh then
		self:_updateParam()
		self:_refreshUI()
	end
end

function RoomManufactureBuildingDetailView:_updateParam()
	self._buildingType = self.viewParam.buildingType
	self._buildingUid = self.viewParam.buildingUid
	self._buildingMO = self.viewParam.buildingMO
	self._builidngCfg = self._buildingMO and self._buildingMO.config
	self._buildingId = self._builidngCfg and self._builidngCfg.buildingId
	self._attrInfoMOList = {}
	self._critterMOList = CritterHelper.getWorkCritterMOListByBuid(self._buildingUid)
	self._critterUidList = {}

	for _, critterMO in ipairs(self._critterMOList) do
		table.insert(self._critterUidList, critterMO.id)
	end

	for _, attrType in ipairs(self._baseAttrTypeList) do
		table.insert(self._attrInfoMOList, self:_getArrtInfoMOByType(attrType))
	end

	self._manufactureItemIdList = ManufactureHelper.findLuckyItemIdListByBUid(self._buildingUid)
end

function RoomManufactureBuildingDetailView:_getArrtInfoMOByType(attrType)
	return CritterHelper.sumArrtInfoMOByAttrId(attrType, self._critterMOList)
end

function RoomManufactureBuildingDetailView:_refreshUI()
	if self._builidngCfg then
		self._txtbuildingName.text = self._builidngCfg.name or ""
	end

	if self._builidngCfg then
		local buildingType = self._builidngCfg.buildingType
		local buildingId = self._builidngCfg.id
		local iconName

		UISpriteSetMgr.instance:setRoomSprite(self._imagebuildingIcon, RoomBuildingEnum.BuildingArea[buildingType] and ManufactureConfig.instance:getManufactureBuildingIcon(buildingId) or RoomConfig.instance:getBuildingTypeIcon(buildingType))
	end

	self:_refreshAttr()
	self:_refreshCritter()
	self:_refreshItem()
end

function RoomManufactureBuildingDetailView:_refreshAttr()
	local attrInfos = self._attrInfoMOList

	for index, attrMO in ipairs(attrInfos) do
		local item = self._attrItemCompList[index]

		if not item then
			local go = gohelper.clone(self._gobaseitem, self._gobaseLayer)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomCritterDetailAttrItem)

			table.insert(self._attrItemCompList, item)
		end

		local value = CritterHelper.sumPreViewAttrValue(attrMO.attributeId, self._critterUidList, self._buildingId, false)
		local valueStr = CritterHelper.formatAttrValue(attrMO.attributeId, value)

		item:onRefreshMo(attrMO, index, valueStr, valueStr, attrMO:getName())
	end

	local count = #attrInfos

	for i = 1, #self._attrItemCompList do
		gohelper.setActive(self._attrItemCompList[i].viewGO, i <= count)
	end
end

function RoomManufactureBuildingDetailView:_refreshCritter()
	local critterMOs = self._critterMOList

	for index, critterMO in ipairs(critterMOs) do
		local item = self._critterDetailCompList[index]

		if not item then
			local go = self.viewContainer:getResInst(RoomManufactureCritterDetail.prefabPath, self._gocritterLayer)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, RoomManufactureCritterDetail)

			table.insert(self._critterDetailCompList, item)
		end

		item:onUpdateMO(critterMO)
	end

	local count = #critterMOs

	for i = 1, #self._critterDetailCompList do
		gohelper.setActive(self._critterDetailCompList[i].viewGO, i <= count)
	end
end

function RoomManufactureBuildingDetailView:_refreshItem()
	local value = CritterHelper.sumPreViewAttrValue(CritterEnum.AttributeType.Efficiency, self._critterUidList, self._buildingId, false)
	local isUp = value > 100

	for index, itemId in ipairs(self._manufactureItemIdList) do
		local itemTb = self._itemTbList[index]

		if not itemTb then
			itemTb = self:getUserDataTb_()

			table.insert(self._itemTbList, itemTb)

			local go = gohelper.cloneInPlace(self._goitem)

			itemTb.go = go
			itemTb.image_quality = gohelper.findChildImage(go, "image_quality")
			itemTb.go_icon = gohelper.findChild(go, "go_icon")
			itemTb.go_up = gohelper.findChild(go, "go_up")
			itemTb.itemIcon = IconMgr.instance:getCommonItemIcon(itemTb.go_icon)

			itemTb.itemIcon:isShowQuality(false)
		end

		itemTb.itemIcon:setMOValue(MaterialEnum.MaterialType.Item, itemId, nil, nil, nil)

		local rare = itemTb.itemIcon:getRare()
		local qualityImg = RoomManufactureEnum.RareImageMap[rare]

		UISpriteSetMgr.instance:setCritterSprite(itemTb.image_quality, qualityImg)
		gohelper.setActive(itemTb.go_up, isUp)
	end

	local count = #self._manufactureItemIdList

	for i = 1, #self._itemTbList do
		gohelper.setActive(self._itemTbList[i].go, i <= count)
	end
end

return RoomManufactureBuildingDetailView
