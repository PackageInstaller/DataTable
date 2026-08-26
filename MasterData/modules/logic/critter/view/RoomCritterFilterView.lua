-- chunkname: @modules/logic/critter/view/RoomCritterFilterView.lua

module("modules.logic.critter.view.RoomCritterFilterView", package.seeall)

local RoomCritterFilterView = class("RoomCritterFilterView", BaseView)

function RoomCritterFilterView:onInitView()
	self._btnclosefilterview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/#btn_closefilterview")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content")
	self._gofilterCategoryItem = gohelper.findChild(self.viewGO, "#go_searchfilter/container/Scroll View/Viewport/Content/filterTypeItem")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_ok")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_searchfilter/container/#btn_reset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterFilterView:addEvents()
	self._btnclosefilterview:AddClickListener(self._btnclosefilterviewOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
end

function RoomCritterFilterView:removeEvents()
	self._btnclosefilterview:RemoveClickListener()
	self._btnok:RemoveClickListener()
	self._btnreset:RemoveClickListener()

	for _, categoryItem in pairs(self.filterCategoryItemDict) do
		for _, tagItem in pairs(categoryItem.tagItemDict) do
			tagItem.btnClick:RemoveClickListener()
		end
	end
end

function RoomCritterFilterView:_btnclosefilterviewOnClick()
	self:closeThis()
end

function RoomCritterFilterView:_btnokOnClick()
	CritterFilterModel.instance:applyMO(self.filterMO)
	self:closeThis()
end

function RoomCritterFilterView:_btnresetOnClick()
	self.filterMO:reset()
	self:refresh()
end

function RoomCritterFilterView:onClickTagItem(tagItem)
	local filterType = tagItem.filterType
	local tagId = tagItem.tagId
	local isSelected = self:isSelectTag(filterType, tagId)

	if isSelected then
		self.filterMO:unselectedTag(filterType, tagId)
	else
		self.filterMO:selectedTag(filterType, tagId)
	end

	self:refreshTag(tagItem)
end

function RoomCritterFilterView:_editableInitView()
	return
end

function RoomCritterFilterView:onUpdateParam()
	self.filterTypeList = self.viewParam.filterTypeList
	self.parentViewName = self.viewParam.viewName
end

function RoomCritterFilterView:onOpen()
	self:onUpdateParam()

	self.filterCategoryItemDict = {}

	local filterMO = CritterFilterModel.instance:getFilterMO(self.parentViewName, true)

	self.filterMO = filterMO:clone()

	gohelper.CreateObjList(self, self._onSetFilterCategoryItem, self.filterTypeList, self._gocontent, self._gofilterCategoryItem)
	self:refresh()
end

function RoomCritterFilterView:_onSetFilterCategoryItem(obj, data, index)
	local categoryItem = self:getUserDataTb_()

	categoryItem.go = obj
	categoryItem.filterType = data

	local cfg = CritterConfig.instance:getCritterFilterTypeCfg(data, true)
	local nameTxt = gohelper.findChildText(categoryItem.go, "title/dmgTypeCn")
	local nameEnTxt = gohelper.findChildText(categoryItem.go, "title/dmgTypeCn/dmgTypeEn")

	nameTxt.text = cfg.name
	nameEnTxt.text = cfg.nameEn

	local golayout = gohelper.findChild(categoryItem.go, "layout")
	local gotabItem1 = gohelper.findChild(categoryItem.go, "layout/#go_tabItem1")
	local gotabItem2 = gohelper.findChild(categoryItem.go, "layout/#go_tabItem2")

	gohelper.setActive(gotabItem1, false)
	gohelper.setActive(gotabItem2, false)

	categoryItem.tagItemDict = {}

	local tabDataList = CritterConfig.instance:getCritterTabDataList(categoryItem.filterType)

	for _, tabData in ipairs(tabDataList) do
		local filterTabId = tabData.filterTab
		local tagGO = gohelper.clone((not string.nilorempty(tabData.icon) or nil) and gotabItem2, golayout, filterTabId)

		categoryItem.tagItemDict[filterTabId] = self:getTagItem(tabData, tagGO, categoryItem.filterType)
	end

	self.filterCategoryItemDict[data] = categoryItem
end

function RoomCritterFilterView:getTagItem(tabData, tagGO, filterType)
	local name = tabData.name
	local icon = tabData.icon
	local tagItem = self:getUserDataTb_()

	tagItem.go = tagGO
	tagItem.tagId = tabData.filterTab
	tagItem.filterType = filterType
	tagItem.gounselected = gohelper.findChild(tagItem.go, "unselected")
	tagItem.goselected = gohelper.findChild(tagItem.go, "selected")
	tagItem.btnClick = gohelper.findChildClickWithAudio(tagItem.go, "click", AudioEnum.UI.UI_Common_Click)

	tagItem.btnClick:AddClickListener(self.onClickTagItem, self, tagItem)

	local unselectedNameTxt = gohelper.findChildText(tagItem.go, "unselected/info1")
	local selectedNameTxt = gohelper.findChildText(tagItem.go, "selected/info2")

	unselectedNameTxt.text = name
	selectedNameTxt.text = name

	local hasIcon = not string.nilorempty(icon)

	if hasIcon then
		local imgunselectedIcon = gohelper.findChildImage(tagItem.go, "unselected/#image_icon")
		local imageselectedicon = gohelper.findChildImage(tagItem.go, "selected/#image_icon")

		UISpriteSetMgr.instance:setCritterSprite(imgunselectedIcon, icon)
		UISpriteSetMgr.instance:setCritterSprite(imageselectedicon, icon)
	end

	gohelper.setActive(tagItem.go, true)

	return tagItem
end

function RoomCritterFilterView:refresh()
	for _, categoryItem in pairs(self.filterCategoryItemDict) do
		for _, tagItem in pairs(categoryItem.tagItemDict) do
			self:refreshTag(tagItem)
		end
	end
end

function RoomCritterFilterView:refreshTag(tagItem)
	local filterType = tagItem.filterType
	local tagId = tagItem.tagId
	local isSelected = self:isSelectTag(filterType, tagId)

	gohelper.setActive(tagItem.goselected, isSelected)
	gohelper.setActive(tagItem.gounselected, not isSelected)
end

function RoomCritterFilterView:isSelectTag(filterType, tagId)
	return (self.filterMO:isSelectedTag(filterType, tagId))
end

function RoomCritterFilterView:onClose()
	return
end

function RoomCritterFilterView:onDestroyView()
	return
end

return RoomCritterFilterView
