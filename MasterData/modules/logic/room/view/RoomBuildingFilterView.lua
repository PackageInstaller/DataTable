-- chunkname: @modules/logic/room/view/RoomBuildingFilterView.lua

module("modules.logic.room.view.RoomBuildingFilterView", package.seeall)

local RoomBuildingFilterView = class("RoomBuildingFilterView", BaseView)

function RoomBuildingFilterView:onInitView()
	self._goraredownselect = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/rare/go_raredown/beselected")
	self._goraredownunselect = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/rare/go_raredown/unselected")
	self._gorareupselect = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/rare/go_rareup/beselected")
	self._gorareupunselect = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/rare/go_rareup/unselected")
	self._goplacedselect = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/placingstate/go_placed/beselected")
	self._goplacedunselect = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/placingstate/go_placed/unselected")
	self._gonotplacedselect = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/placingstate/go_notplaced/beselected")
	self._gonotplacedunselect = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/placingstate/go_notplaced/unselected")
	self._gorange = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/go_range")
	self._gorangeitem = gohelper.findChild(self.viewGO, "#scrollview/viewport/content/go_range/go_rangeitem")
	self._btnraredown = gohelper.findChildButtonWithAudio(self.viewGO, "#scrollview/viewport/content/rare/go_raredown/click")
	self._btnrareup = gohelper.findChildButtonWithAudio(self.viewGO, "#scrollview/viewport/content/rare/go_rareup/click")
	self._btnplaced = gohelper.findChildButtonWithAudio(self.viewGO, "#scrollview/viewport/content/placingstate/go_placed/click")
	self._btnnotplaced = gohelper.findChildButtonWithAudio(self.viewGO, "#scrollview/viewport/content/placingstate/go_notplaced/click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomBuildingFilterView:addEvents()
	self._btnraredown:AddClickListener(self._btnraredownOnClick, self)
	self._btnrareup:AddClickListener(self._btnrareupOnClick, self)
	self._btnplaced:AddClickListener(self._btnplacedOnClick, self)
	self._btnnotplaced:AddClickListener(self._btnnotplacedOnClick, self)
end

function RoomBuildingFilterView:removeEvents()
	self._btnraredown:RemoveClickListener()
	self._btnrareup:RemoveClickListener()
	self._btnplaced:RemoveClickListener()
	self._btnnotplaced:RemoveClickListener()
end

function RoomBuildingFilterView:_btnraredownOnClick()
	if not RoomShowBuildingListModel.instance:isRareDown() then
		RoomShowBuildingListModel.instance:setRareDown(true)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	self:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function RoomBuildingFilterView:_btnrareupOnClick()
	if RoomShowBuildingListModel.instance:isRareDown() then
		RoomShowBuildingListModel.instance:setRareDown(false)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	self:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function RoomBuildingFilterView:_btnnotplacedOnClick()
	self:_setFilterUse(0)
end

function RoomBuildingFilterView:_btnplacedOnClick()
	self:_setFilterUse(1)
end

function RoomBuildingFilterView:_setFilterUse(use)
	if RoomShowBuildingListModel.instance:isFilterUse(use) then
		RoomShowBuildingListModel.instance:removeFilterUse(use)
	else
		RoomShowBuildingListModel.instance:addFilterUse(use)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	self:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function RoomBuildingFilterView:_btnrangeOnClick(occupyId)
	if RoomShowBuildingListModel.instance:isFilterOccupy(occupyId) then
		RoomShowBuildingListModel.instance:removeFilterOccupy(occupyId)
	else
		RoomShowBuildingListModel.instance:addFilterOccupy(occupyId)
	end

	RoomShowBuildingListModel.instance:setShowBuildingList()
	self:_refreshFilter()
	RoomMapController.instance:dispatchEvent(RoomEvent.BuildingFilterChanged)
end

function RoomBuildingFilterView:_editableInitView()
	gohelper.setActive(self._gorangeitem, false)

	self._rangeItemList = {}

	local occupyList = RoomConfig.instance:getBuildingOccupyList()

	for _, occupyId in ipairs(occupyList) do
		local rangeItem = self:_createTbItem(self._gorange, "rangeitem" .. occupyId)

		rangeItem.occupyId = occupyId

		local num = RoomConfig.instance:getBuildingOccupyNum(occupyId)
		local icon = RoomConfig.instance:getBuildingOccupyIcon(occupyId)

		rangeItem.txtnum.text = num

		UISpriteSetMgr.instance:setRoomSprite(rangeItem.imageicon, icon)
		rangeItem.btnclick:AddClickListener(self._btnrangeOnClick, self, rangeItem.occupyId)
		table.insert(self._rangeItemList, rangeItem)
	end
end

function RoomBuildingFilterView:_createTbItem(parentGO, name)
	local rangeItem = self:getUserDataTb_()

	rangeItem.go = gohelper.clone(self._gorangeitem, parentGO, name)
	rangeItem.goselect = gohelper.findChild(rangeItem.go, "beselected")
	rangeItem.gounselect = gohelper.findChild(rangeItem.go, "unselected")
	rangeItem.imageicon = gohelper.findChildImage(rangeItem.go, "layout/num/icon")
	rangeItem.txtnum = gohelper.findChildText(rangeItem.go, "layout/num")
	rangeItem.btnclick = gohelper.findChildButtonWithAudio(rangeItem.go, "click")

	gohelper.addUIClickAudio(rangeItem.btnclick.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.setActive(rangeItem.go, true)

	return rangeItem
end

function RoomBuildingFilterView:_refreshFilter()
	gohelper.setActive(self._goraredownselect, RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(self._goraredownunselect, not RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(self._gorareupselect, not RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(self._gorareupunselect, RoomShowBuildingListModel.instance:isRareDown())
	gohelper.setActive(self._goplacedselect, RoomShowBuildingListModel.instance:isFilterUse(1))
	gohelper.setActive(self._goplacedunselect, not RoomShowBuildingListModel.instance:isFilterUse(1))
	gohelper.setActive(self._gonotplacedselect, RoomShowBuildingListModel.instance:isFilterUse(0))
	gohelper.setActive(self._gonotplacedunselect, not RoomShowBuildingListModel.instance:isFilterUse(0))

	for i, rangeItem in ipairs(self._rangeItemList) do
		local isSelected = RoomShowBuildingListModel.instance:isFilterOccupy(rangeItem.occupyId)

		SLFramework.UGUI.GuiHelper.SetColor(rangeItem.imageicon, isSelected and "#EC7E4B" or "#E5E5E5")
		SLFramework.UGUI.GuiHelper.SetColor(rangeItem.txtnum, isSelected and "#EC7E4B" or "#E5E5E5")
		gohelper.setActive(rangeItem.goselect, isSelected)
		gohelper.setActive(rangeItem.gounselect, not isSelected)
	end
end

function RoomBuildingFilterView:_addBtnAudio()
	gohelper.addUIClickAudio(self._btnraredown.gameObject, AudioEnum.UI.play_ui_role_open)
	gohelper.addUIClickAudio(self._btnrareup.gameObject, AudioEnum.UI.play_ui_role_open)
	gohelper.addUIClickAudio(self._btnplaced.gameObject, AudioEnum.UI.play_ui_role_open)
	gohelper.addUIClickAudio(self._btnnotplaced.gameObject, AudioEnum.UI.play_ui_role_open)
end

function RoomBuildingFilterView:onOpen()
	self:_addBtnAudio()
	self:_refreshFilter()
end

function RoomBuildingFilterView:onClose()
	return
end

function RoomBuildingFilterView:onDestroyView()
	for i, rangeItem in ipairs(self._rangeItemList) do
		rangeItem.btnclick:RemoveClickListener()
	end
end

return RoomBuildingFilterView
