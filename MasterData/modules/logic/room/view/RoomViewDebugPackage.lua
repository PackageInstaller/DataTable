-- chunkname: @modules/logic/room/view/RoomViewDebugPackage.lua

module("modules.logic.room.view.RoomViewDebugPackage", package.seeall)

local RoomViewDebugPackage = class("RoomViewDebugPackage", BaseView)

function RoomViewDebugPackage:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomViewDebugPackage:addEvents()
	return
end

function RoomViewDebugPackage:removeEvents()
	return
end

function RoomViewDebugPackage:_btnpackageidOnClick(index)
	local packageIdItem = self._packageIdItemList[index]

	RoomDebugPackageListModel.instance:setFilterPackageId(packageIdItem.packageId)
	RoomDebugPackageListModel.instance:setDebugPackageList()
	RoomDebugPackageListModel.instance:clearSelect()
	self:_refreshPackageId()
	RoomDebugController.instance:dispatchEvent(RoomEvent.DebugPackageFilterChanged)

	self._scrolldebugpackage.horizontalNormalizedPosition = 0
end

function RoomViewDebugPackage:_btnmainresOnClick(index)
	local mainResItem = self._mainResItemList[index]

	RoomDebugPackageListModel.instance:setFilterMainRes((mainResItem.resourceId >= 0 or nil) and (mainResItem.resourceId or nil))
	RoomDebugPackageListModel.instance:setDebugPackageList()
	RoomDebugPackageListModel.instance:clearSelect()
	self:_refreshMainRes()
	RoomDebugController.instance:dispatchEvent(RoomEvent.DebugPackageFilterChanged)

	self._scrolldebugpackage.horizontalNormalizedPosition = 0
end

function RoomViewDebugPackage:_editableInitView()
	self._godebugpackage = gohelper.findChild(self.viewGO, "go_normalroot/go_debugpackage")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/go_debugpackage/btn_close")
	self._gopackageiditem = gohelper.findChild(self.viewGO, "go_normalroot/go_debugpackage/filterpackageid/viewport/content/go_packageiditem")
	self._gomainresitem = gohelper.findChild(self.viewGO, "go_normalroot/go_debugpackage/filtermainres/go_mainresitem")
	self._scrolldebugpackage = gohelper.findChildScrollRect(self.viewGO, "go_normalroot/go_debugpackage/scroll_debugpackage")
	self._btnpackageidmode = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/go_debugpackage/btn_packageidmode")
	self._goselectpackageidmode = gohelper.findChild(self.viewGO, "go_normalroot/go_debugpackage/btn_packageidmode/go_selectpackageidmode")
	self._btnpackageordermode = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/go_debugpackage/btn_packageordermode")
	self._goselectpackageordermode = gohelper.findChild(self.viewGO, "go_normalroot/go_debugpackage/btn_packageordermode/go_selectpackageordermode")
	self._btnthemfilter = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/go_debugpackage/btn_themfilter")
	self._goselectthemfilter = gohelper.findChild(self.viewGO, "go_normalroot/go_debugpackage/btn_themfilter/go_selectthemfilter")

	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnpackageidmode:AddClickListener(self._btnpackageidmodeOnClick, self)
	self._btnpackageordermode:AddClickListener(self._btnpackageordermodeOnClick, self)
	self._btnthemfilter:AddClickListener(self._btnthemfilterOnClick, self)

	self._isShowDebugPackage = false

	gohelper.setActive(self._godebugpackage, false)

	self._packageIdItemList = {}
	self._mainResItemList = {}

	gohelper.setActive(self._gopackageiditem, false)
	gohelper.setActive(self._gomainresitem, false)
	gohelper.setActive(self._goselectthemfilter, false)
	self:_initPackageId()
	self:_initMainRes()

	self._scene = GameSceneMgr.instance:getCurScene()
end

function RoomViewDebugPackage:_btncloseOnClick()
	RoomDebugController.instance:setDebugPackageListShow(false)
end

function RoomViewDebugPackage:_btnpackageidmodeOnClick()
	RoomDebugController.instance:setEditPackageOrder(false)
	self:_refreshPackageMode()
end

function RoomViewDebugPackage:_btnpackageordermodeOnClick()
	RoomDebugController.instance:setEditPackageOrder(true)
	self:_refreshPackageMode()
end

function RoomViewDebugPackage:_btnthemfilterOnClick()
	ViewMgr.instance:openView(ViewName.RoomDebugThemeFilterView)
end

function RoomViewDebugPackage:_refreshPackageMode()
	local isEditPackageOrder = RoomDebugController.instance:isEditPackageOrder()

	gohelper.setActive(self._goselectpackageidmode, not isEditPackageOrder)
	gohelper.setActive(self._goselectpackageordermode, isEditPackageOrder)
end

function RoomViewDebugPackage:_refreshUI()
	self:_refreshPackageId()
	self:_refreshMainRes()
	self:_refreshPackageMode()
end

function RoomViewDebugPackage:_initPackageId()
	local list = lua_block_package.configList

	table.sort(list, function(x, y)
		return x.id < y.id
	end)

	for i, packageConfig in ipairs(list) do
		local packageIdItem = self._packageIdItemList[i]

		if not packageIdItem then
			packageIdItem = self:getUserDataTb_()
			packageIdItem.index = i
			packageIdItem.go = gohelper.cloneInPlace(self._gopackageiditem, "item" .. i)
			packageIdItem.gobeselect = gohelper.findChild(packageIdItem.go, "go_beselect")
			packageIdItem.gounselect = gohelper.findChild(packageIdItem.go, "go_unselect")
			packageIdItem.txtbeselectname = gohelper.findChildText(packageIdItem.go, "go_beselect/txt_name")
			packageIdItem.txtunselectname = gohelper.findChildText(packageIdItem.go, "go_unselect/txt_name")
			packageIdItem.btnclick = gohelper.findChildButtonWithAudio(packageIdItem.go, "btn_click")

			packageIdItem.btnclick:AddClickListener(self._btnpackageidOnClick, self, packageIdItem.index)
			table.insert(self._packageIdItemList, packageIdItem)
		end

		packageIdItem.packageId = packageConfig.id
		packageIdItem.txtbeselectname.text = packageConfig.name
		packageIdItem.txtunselectname.text = packageConfig.name

		gohelper.setActive(packageIdItem.go, true)
	end

	for i = #list + 1, #self._packageIdItemList do
		local packageIdItem = self._packageIdItemList[i]

		gohelper.setActive(packageIdItem.go, false)
	end

	self:_refreshPackageId()
end

function RoomViewDebugPackage:_refreshPackageId()
	for i, packageIdItem in ipairs(self._packageIdItemList) do
		gohelper.setActive(packageIdItem.gobeselect, RoomDebugPackageListModel.instance:isFilterPackageId(packageIdItem.packageId))
		gohelper.setActive(packageIdItem.gounselect, not RoomDebugPackageListModel.instance:isFilterPackageId(packageIdItem.packageId))
	end
end

function RoomViewDebugPackage:_initMainRes()
	local list = {}

	table.insert(list, -1)

	for _, resourceId in pairs(RoomResourceEnum.ResourceId) do
		if resourceId >= 0 then
			table.insert(list, resourceId)
		end
	end

	table.sort(list, function(x, y)
		return x < y
	end)

	for i, resourceId in ipairs(list) do
		local mainResItem = self._mainResItemList[i]

		if not mainResItem then
			mainResItem = self:getUserDataTb_()
			mainResItem.index = i
			mainResItem.go = gohelper.cloneInPlace(self._gomainresitem, "item" .. i)
			mainResItem.gobeselect = gohelper.findChild(mainResItem.go, "go_beselect")
			mainResItem.gounselect = gohelper.findChild(mainResItem.go, "go_unselect")
			mainResItem.txtbeselectname = gohelper.findChildText(mainResItem.go, "go_beselect/txt_name")
			mainResItem.txtunselectname = gohelper.findChildText(mainResItem.go, "go_unselect/txt_name")
			mainResItem.txtcount = gohelper.findChildText(mainResItem.go, "txt_count")
			mainResItem.btnclick = gohelper.findChildButtonWithAudio(mainResItem.go, "btn_click")

			mainResItem.btnclick:AddClickListener(self._btnmainresOnClick, self, mainResItem.index)
			table.insert(self._mainResItemList, mainResItem)
		end

		mainResItem.resourceId = resourceId

		local name = "空"

		if resourceId > 0 then
			local resourceConfig = RoomConfig.instance:getResourceConfig(resourceId)

			if resourceConfig then
				name = resourceConfig.name
			else
				logError(string.format("[X小屋地块包表.xlsx] [export_地块资源] 找不到资源id:[%s]", resourceId))

				name = "未知:" .. resourceId
			end
		elseif resourceId < 0 then
			name = "未分类"
		end

		mainResItem.txtbeselectname.text = name
		mainResItem.txtunselectname.text = name

		gohelper.setActive(mainResItem.go, true)
	end

	for i = #list + 1, #self._mainResItemList do
		local mainResItem = self._mainResItemList[i]

		gohelper.setActive(mainResItem.go, false)
	end

	self:_refreshMainRes()
end

function RoomViewDebugPackage:_refreshMainRes()
	local filterMainRes = RoomDebugPackageListModel.instance:getFilterMainRes()

	for i, mainResItem in ipairs(self._mainResItemList) do
		local select = filterMainRes == mainResItem.resourceId or mainResItem.resourceId < 0 and not filterMainRes

		gohelper.setActive(mainResItem.gobeselect, select)
		gohelper.setActive(mainResItem.gounselect, not select)

		mainResItem.txtcount.text = RoomDebugPackageListModel.instance:getCountByMainRes(mainResItem.resourceId)
	end
end

function RoomViewDebugPackage:_themeFilterChanged()
	local tRoomDebugThemeFilterListModel = RoomDebugThemeFilterListModel.instance
	local materialType = MaterialEnum.MaterialType.BlockPackage

	for i = 1, #self._packageIdItemList do
		local packageIdItem = self._packageIdItemList[i]

		gohelper.setActive(packageIdItem.go, tRoomDebugThemeFilterListModel:checkSelectByItem(packageIdItem.packageId, materialType))
	end

	gohelper.setActive(self._goselectthemfilter, tRoomDebugThemeFilterListModel:getIsAll() or tRoomDebugThemeFilterListModel:getSelectCount() > 0)
end

function RoomViewDebugPackage:_debugPackageListViewShowChanged(isShowDebugPackage)
	self._isShowDebugPackage = isShowDebugPackage

	RoomDebugPackageListModel.instance:clearSelect()
	gohelper.setActive(self._godebugpackage, isShowDebugPackage)

	if isShowDebugPackage then
		RoomDebugPackageListModel.instance:setDebugPackageList()

		self._scrolldebugpackage.horizontalNormalizedPosition = 0
	end
end

function RoomViewDebugPackage:_addBtnAudio()
	gohelper.addUIClickAudio(self._btnclose.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function RoomViewDebugPackage:onOpen()
	self:_refreshUI()
	self:_addBtnAudio()
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, self._debugPackageListViewShowChanged, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugSetPackage, self._refreshMainRes, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, self._refreshMainRes, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPackageOrderChanged, self._refreshMainRes, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.DebugPackageFilterChanged, self._refreshMainRes, self)
	self.addEventCb(self, RoomDebugController.instance, RoomEvent.UIRoomThemeFilterChanged, self._themeFilterChanged, self)
	RoomDebugThemeFilterListModel.instance:init()
end

function RoomViewDebugPackage:onClose()
	return
end

function RoomViewDebugPackage:onDestroyView()
	for i, packageIdItem in ipairs(self._packageIdItemList) do
		packageIdItem.btnclick:RemoveClickListener()
	end

	for i, mainResItem in ipairs(self._mainResItemList) do
		mainResItem.btnclick:RemoveClickListener()
	end

	self._btnclose:RemoveClickListener()
	self._scrolldebugpackage:RemoveOnValueChanged()
	self._btnpackageidmode:RemoveClickListener()
	self._btnpackageordermode:RemoveClickListener()
	self._btnthemfilter:RemoveClickListener()
end

return RoomViewDebugPackage
