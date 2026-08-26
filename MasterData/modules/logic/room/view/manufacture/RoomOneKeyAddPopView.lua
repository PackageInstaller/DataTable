-- chunkname: @modules/logic/room/view/manufacture/RoomOneKeyAddPopView.lua

module("modules.logic.room.view.manufacture.RoomOneKeyAddPopView", package.seeall)

local RoomOneKeyAddPopView = class("RoomOneKeyAddPopView", BaseView)
local DEFAULT_TAB_INDEX = 1

function RoomOneKeyAddPopView:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "right/#go_addPop/#txt_title")
	self._btncloseAdd = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_addPop/#btn_closeAdd")
	self._gotabparent = gohelper.findChild(self.viewGO, "right/#go_addPop/#go_tabList")
	self._gotabitem = gohelper.findChild(self.viewGO, "right/#go_addPop/#go_tabList/#go_tabItem")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_addPop/#go_num/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_addPop/#go_num/#btn_sub")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "right/#go_addPop/#go_num/valuebg/#input_value")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_addPop/#go_num/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_addPop/#go_num/#btn_max")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomOneKeyAddPopView:addEvents()
	self._btncloseAdd:AddClickListener(self._btncloseAddOnClick, self)
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._inputvalue:AddOnValueChanged(self._onInputValueChange, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, self.refreshCount, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self, LuaEventSystem.High)
end

function RoomOneKeyAddPopView:removeEvents()
	self._btncloseAdd:RemoveClickListener()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._inputvalue:RemoveOnValueChanged()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, self.refreshCount, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)

	if self.tabItemList then
		for _, tabItem in ipairs(self.tabItemList) do
			tabItem.click:RemoveClickListener()
		end
	end
end

function RoomOneKeyAddPopView:_btncloseAddOnClick()
	self.viewContainer:oneKeyViewSetAddPopActive(false)
end

function RoomOneKeyAddPopView:_tabItemOnClick(index)
	if self._selectTabIndex == index then
		return
	end

	if self.tabItemList then
		local tabItem = self.tabItemList[index]

		if not tabItem then
			return
		end

		local preTabItem = self.tabItemList[self._selectTabIndex]

		if preTabItem then
			gohelper.setActive(preTabItem.goSelected, false)
			gohelper.setActive(preTabItem.goUnselected, true)
			SLFramework.UGUI.GuiHelper.SetColor(preTabItem.icon, "#5C5B5A")
		end

		gohelper.setActive(tabItem.goSelected, true)
		gohelper.setActive(tabItem.goUnselected, false)
		SLFramework.UGUI.GuiHelper.SetColor(tabItem.icon, "#BB693D")

		self._selectTabIndex = index

		local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(tabItem.idList[1])

		if buildingMO then
			if not buildingMO.config.useDesc then
				self._txttitle.text = ""

				OneKeyAddPopListModel.instance:setOneKeyFormulaItemList(tabItem.idList)
			end
		end
	end
end

function RoomOneKeyAddPopView:_btnminOnClick()
	self:changeCount(OneKeyAddPopListModel.MINI_COUNT)
end

function RoomOneKeyAddPopView:_btnsubOnClick()
	local _, count = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	self:changeCount(count - 1)
end

function RoomOneKeyAddPopView:_onInputValueChange(value)
	self:changeCount(tonumber(value))
end

function RoomOneKeyAddPopView:_btnaddOnClick()
	local _, count = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	self:changeCount(count + 1)
end

function RoomOneKeyAddPopView:_btnmaxOnClick()
	local curManufactureItem = OneKeyAddPopListModel.instance:getSelectedManufactureItem()
	local maxCount = ManufactureModel.instance:getMaxCanProductCount(curManufactureItem)

	self:changeCount(maxCount)
end

function RoomOneKeyAddPopView:changeCount(count)
	local curManufactureItem = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if not curManufactureItem then
		GameFacade.showToast(ToastEnum.RoomNotSelectedManufactureItem)

		return
	end

	count = count or OneKeyAddPopListModel.MINI_COUNT

	local maxCount = ManufactureModel.instance:getMaxCanProductCount(curManufactureItem)

	count = Mathf.Clamp(count, OneKeyAddPopListModel.MINI_COUNT, maxCount)

	ManufactureController.instance:oneKeySelectCustomManufactureItem(curManufactureItem, count, true)
end

function RoomOneKeyAddPopView:_onItemChanged()
	ManufactureController.instance:updateTraceNeedItemDict()
end

function RoomOneKeyAddPopView:_editableInitView()
	gohelper.setActive(self._btncloseAdd, false)
	ManufactureController.instance:updateTraceNeedItemDict()
end

function RoomOneKeyAddPopView:onUpdateParam()
	return
end

function RoomOneKeyAddPopView:onOpen()
	self:initTab()

	local defaultIndex = self:getDefaultTabIndex()

	self:_tabItemOnClick(defaultIndex)
	self:refreshCount()
end

function RoomOneKeyAddPopView:getDefaultTabIndex()
	local curManufactureItem = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if not curManufactureItem then
		return DEFAULT_TAB_INDEX
	end

	local produceBuildingList = ManufactureConfig.instance:getManufactureItemBelongBuildingList(curManufactureItem)
	local produceBuildingDict = {}

	for _, buildingId in ipairs(produceBuildingList) do
		produceBuildingDict[buildingId] = true
	end

	for i, tabItem in ipairs(self.tabItemList) do
		for _, buildingUid in ipairs(tabItem.idList) do
			local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(buildingUid)

			if buildingMO and produceBuildingDict[buildingMO.buildingId] then
				return i
			end
		end
	end

	return DEFAULT_TAB_INDEX
end

function RoomOneKeyAddPopView:initTab()
	if self.tabItemList then
		for _, tabItem in ipairs(self.tabItemList) do
			tabItem.click:removeClickListener()
		end
	end

	self.tabItemList = {}

	local tabList = OneKeyAddPopListModel.instance:getTabDataList()

	gohelper.CreateObjList(self, self.onSetTabItem, tabList, self._gotabparent, self._gotabitem)
end

function RoomOneKeyAddPopView:onSetTabItem(obj, data, index)
	local tabItem = self:getUserDataTb_()

	tabItem.go = obj
	tabItem.idList = data
	tabItem.icon = gohelper.findChildImage(obj, "#simage_icon")
	tabItem.goSelected = gohelper.findChild(obj, "#go_selected")
	tabItem.goUnselected = gohelper.findChild(obj, "#go_unselected")
	tabItem.click = gohelper.findChildClickWithDefaultAudio(obj, "#btn_click")

	tabItem.click:AddClickListener(self._tabItemOnClick, self, index)

	local iconName
	local buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(tabItem.idList[1])

	if buildingMO then
		local buildingId = buildingMO.buildingId
		local buildingType = RoomConfig.instance:getBuildingType(buildingId)

		iconName = #tabItem.idList > 1 and RoomConfig.instance:getBuildingTypeIcon(buildingType) or ManufactureConfig.instance:getManufactureBuildingIcon(buildingId)
	end

	UISpriteSetMgr.instance:setRoomSprite(tabItem.icon, iconName)

	self.tabItemList[index] = tabItem
end

function RoomOneKeyAddPopView:refreshCount()
	local _, count = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	self._inputvalue:SetTextWithoutNotify(tostring(count))
end

function RoomOneKeyAddPopView:onClose()
	return
end

function RoomOneKeyAddPopView:onDestroyView()
	return
end

return RoomOneKeyAddPopView
