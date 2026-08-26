-- chunkname: @modules/logic/room/view/RoomViewDebugPlace.lua

module("modules.logic.room.view.RoomViewDebugPlace", package.seeall)

local RoomViewDebugPlace = class("RoomViewDebugPlace", BaseView)

function RoomViewDebugPlace:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewDebugPlace:addEvents()
	return
end

function RoomViewDebugPlace:removeEvents()
	return
end

function RoomViewDebugPlace:_btncloseOnClick()
	RoomDebugController.instance:setDebugPlaceListShow(false)
end

function RoomViewDebugPlace:_btncategoryOnClick(index)
	local categoryItem = self._categoryItemList[index]
	local category = categoryItem.category

	if category == "未分类" or string.nilorempty(category) then
		RoomDebugPlaceListModel.instance:setFilterCategory(nil)
	else
		RoomDebugPlaceListModel.instance:setFilterCategory(category)
	end

	RoomDebugPlaceListModel.instance:setDebugPlaceList()
	RoomDebugPlaceListModel.instance:clearSelect()
	self:_refreshCategory()

	self._scrolldebugplace.horizontalNormalizedPosition = 0
end

function RoomViewDebugPlace:_editableInitView()
	self._godebugplace = gohelper.findChild(self.viewGO, "go_normalroot/go_debugplace")
	self._gocategoryitem = gohelper.findChild(self.viewGO, "go_normalroot/go_debugplace/filtercategory/viewport/content/go_categoryitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/go_debugplace/btn_close")
	self._scrolldebugplace = gohelper.findChildScrollRect(self.viewGO, "go_normalroot/go_debugplace/scroll_debugplace")
	self._gopackageiditem = gohelper.findChild(self.viewGO, "go_normalroot/go_debugplace/filterpackageid/viewport/content/go_packageiditem")

	self._btnclose:AddClickListener(self._btncloseOnClick, self)

	self._isShowDebugPlace = false

	gohelper.setActive(self._godebugplace, false)

	self._scene = GameSceneMgr.instance:getCurScene()
	self._categoryItemList = {}

	gohelper.setActive(self._gocategoryitem, false)

	self._packageIdItemList = {}

	gohelper.setActive(self._gopackageiditem, false)
	self:_initCategory()
	self:_initPackageId()
	OrthCameraRTMgr.instance:initRT()
	CameraMgr.instance:setOrthCameraActive(true)
end

function RoomViewDebugPlace:_initPackageId()
	local list = lua_block_package.configList

	table.sort(list, function(x, y)
		return x.id < y.id
	end)

	for i, packageConfig in ipairs(list) do
		local packageIdItem = self:getUserDataTb_()

		packageIdItem.index = i
		packageIdItem.go = gohelper.cloneInPlace(self._gopackageiditem, "item" .. i)
		packageIdItem.gobeselect = gohelper.findChild(packageIdItem.go, "go_beselect")
		packageIdItem.gounselect = gohelper.findChild(packageIdItem.go, "go_unselect")
		packageIdItem.txtbeselectname = gohelper.findChildText(packageIdItem.go, "go_beselect/txt_name")
		packageIdItem.txtunselectname = gohelper.findChildText(packageIdItem.go, "go_unselect/txt_name")
		packageIdItem.btnclick = gohelper.findChildButtonWithAudio(packageIdItem.go, "btn_click")

		packageIdItem.btnclick:AddClickListener(self._btnpackageidOnClick, self, packageIdItem.index)

		packageIdItem.packageId = packageConfig.id
		packageIdItem.txtbeselectname.text = packageConfig.name
		packageIdItem.txtunselectname.text = packageConfig.name

		table.insert(self._packageIdItemList, packageIdItem)
		gohelper.setActive(packageIdItem.go, true)
	end

	self:_refreshPackageId()
end

function RoomViewDebugPlace:_initCategory()
	local blockDefineConfigDict = RoomConfig.instance:getBlockDefineConfigDict()
	local list = {}
	local dict = {}

	for _, blockDefineConfig in pairs(blockDefineConfigDict) do
		local category = blockDefineConfig.category

		if string.nilorempty(category) then
			category = "未分类"
		end

		if not dict[category] then
			dict[category] = {}

			table.insert(list, category)
		end
	end

	for i, category in ipairs(list) do
		local categoryItem = self._categoryItemList[i]

		if not categoryItem then
			categoryItem = self:getUserDataTb_()
			categoryItem.index = i
			categoryItem.go = gohelper.cloneInPlace(self._gocategoryitem, "item" .. i)
			categoryItem.gobeselect = gohelper.findChild(categoryItem.go, "go_beselect")
			categoryItem.gounselect = gohelper.findChild(categoryItem.go, "go_unselect")
			categoryItem.txtbeselectname = gohelper.findChildText(categoryItem.go, "go_beselect/txt_name")
			categoryItem.txtunselectname = gohelper.findChildText(categoryItem.go, "go_unselect/txt_name")
			categoryItem.btnclick = gohelper.findChildButtonWithAudio(categoryItem.go, "btn_click")

			categoryItem.btnclick:AddClickListener(self._btncategoryOnClick, self, categoryItem.index)
			table.insert(self._categoryItemList, categoryItem)
		end

		categoryItem.category = category
		categoryItem.txtbeselectname.text = categoryItem.category
		categoryItem.txtunselectname.text = categoryItem.category

		gohelper.setActive(categoryItem.go, true)
	end

	for i = #list + 1, #self._categoryItemList do
		local categoryItem = self._categoryItemList[i]

		gohelper.setActive(categoryItem.go, false)
	end

	self:_refreshCategory()
end

function RoomViewDebugPlace:_refreshCategory()
	local filterCategory = RoomDebugPlaceListModel.instance:getFilterCategory()

	for i, categoryItem in ipairs(self._categoryItemList) do
		local select = filterCategory == categoryItem.category

		if string.nilorempty(filterCategory) and categoryItem.category == "未分类" then
			select = true
		end

		gohelper.setActive(categoryItem.gobeselect, select)
		gohelper.setActive(categoryItem.gounselect, not select)
	end
end

function RoomViewDebugPlace:_refreshUI()
	self:_refreshPackageId()
end

function RoomViewDebugPlace:_btnpackageidOnClick(index)
	local packageIdItem = self._packageIdItemList[index]

	RoomDebugPlaceListModel.instance:setFilterPackageId(packageIdItem.packageId)
	RoomDebugPlaceListModel.instance:setDebugPlaceList()
	RoomDebugPlaceListModel.instance:clearSelect()
	self:_refreshPackageId()
end

function RoomViewDebugPlace:_refreshPackageId()
	for i, packageIdItem in ipairs(self._packageIdItemList) do
		gohelper.setActive(packageIdItem.gobeselect, RoomDebugPlaceListModel.instance:isFilterPackageId(packageIdItem.packageId))
		gohelper.setActive(packageIdItem.gounselect, not RoomDebugPlaceListModel.instance:isFilterPackageId(packageIdItem.packageId))
	end
end

function RoomViewDebugPlace:_debugPlaceListViewShowChanged(isShowDebugPlace)
	self._isShowDebugPlace = isShowDebugPlace

	RoomDebugPlaceListModel.instance:clearSelect()
	gohelper.setActive(self._godebugplace, isShowDebugPlace)

	if isShowDebugPlace then
		RoomDebugPlaceListModel.instance:setDebugPlaceList()

		self._scrolldebugplace.horizontalNormalizedPosition = 0
	end
end

function RoomViewDebugPlace:_addBtnAudio()
	gohelper.addUIClickAudio(self._btnclose.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function RoomViewDebugPlace:onOpen()
	self:_refreshUI()
	self:_addBtnAudio()
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, self._debugPlaceListViewShowChanged, self)
end

function RoomViewDebugPlace:onClose()
	return
end

function RoomViewDebugPlace:onDestroyView()
	for i, categoryItem in ipairs(self._categoryItemList) do
		categoryItem.btnclick:RemoveClickListener()
	end

	self._btnclose:RemoveClickListener()
	self._scrolldebugplace:RemoveOnValueChanged()
	OrthCameraRTMgr.instance:destroyRT()
	CameraMgr.instance:setOrthCameraActive(false)
end

return RoomViewDebugPlace
