-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureOverView.lua

module("modules.logic.room.view.manufacture.RoomManufactureOverView", package.seeall)

local RoomManufactureOverView = class("RoomManufactureOverView", BaseView)

function RoomManufactureOverView:onInitView()
	self._btnoneKeyCritter = gohelper.findChildButtonWithAudio(self.viewGO, "bottomBtns/#btn_oneKeyCritter")
	self._btnoneKeyManu = gohelper.findChildButtonWithAudio(self.viewGO, "bottomBtns/#btn_oneKeyManu")
	self._btnpopBlock = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_popBlock")
	self._goscrollbuilding = gohelper.findChild(self.viewGO, "centerArea/#go_building/#scroll_building")
	self._scrollbuilding = gohelper.findChildScrollRect(self.viewGO, "centerArea/#go_building/#scroll_building")
	self._transscrollbuilding = self._goscrollbuilding.transform
	self._gobuildingContent = gohelper.findChild(self.viewGO, "centerArea/#go_building/#scroll_building/viewport/content")
	self._gobuildingItem = gohelper.findChild(self.viewGO, "centerArea/#go_building/#scroll_building/viewport/content/#go_buildingItem")
	self._goslotItem = gohelper.findChild(self.viewGO, "centerArea/#go_building/#scroll_building/viewport/content/#go_buildingItem/manufactureInfo/#scroll_slot/slotViewport/slotContent/#go_slotItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureOverView:addEvents()
	self._btnoneKeyCritter:AddClickListener(self._btnoneKeyCritterOnClick, self)
	self._btnoneKeyManu:AddClickListener(self._btnoneKeyManuOnClick, self)
	self._btnpopBlock:AddClickListener(self._btnpopBlockOnClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, self._onChangeSelectedSlotItem, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.TradeLevelChange, self._onTradeLevelChange, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureBuildingInfoChange, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BuildingLevelUpPush, self._onBuildingLevelUp, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewChange, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureOverViewFocusAddPop, self._focusBuildingItemAddPop, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.GuideFocusCritter, self._onGuideFocusCritter, self)
end

function RoomManufactureOverView:removeEvents()
	self._btnoneKeyCritter:RemoveClickListener()
	self._btnoneKeyManu:RemoveClickListener()
	self._btnpopBlock:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, self._onChangeSelectedSlotItem, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.TradeLevelChange, self._onTradeLevelChange, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureBuildingInfoChange, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.BuildingLevelUpPush, self._onBuildingLevelUp, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewChange, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureOverViewFocusAddPop, self._focusBuildingItemAddPop, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.GuideFocusCritter, self._onGuideFocusCritter, self)
end

function RoomManufactureOverView:_btnoneKeyCritterOnClick()
	ManufactureController.instance:oneKeyCritter()
end

function RoomManufactureOverView:_btnoneKeyManuOnClick()
	ViewMgr.instance:openView(ViewName.RoomOneKeyView)
end

function RoomManufactureOverView:_btnpopBlockOnClick()
	self:closePopView()
end

function RoomManufactureOverView:_onChangeSelectedSlotItem()
	local selectedBuildingUid, _ = ManufactureModel.instance:getSelectedSlot()

	if selectedBuildingUid then
		self:_setAddPopItems(selectedBuildingUid)
	end

	for _, buildingItem in pairs(self._overBuildingItemDict) do
		buildingItem:onChangeSelectedSlotItem()
	end
end

function RoomManufactureOverView:_onManufactureInfoUpdate()
	for _, buildingItem in pairs(self._overBuildingItemDict) do
		buildingItem:onManufactureInfoUpdate()
	end
end

function RoomManufactureOverView:_onTradeLevelChange()
	for _, buildingItem in pairs(self._overBuildingItemDict) do
		buildingItem:onTradeLevelChange()
	end
end

function RoomManufactureOverView:_onManufactureBuildingInfoChange(changeBuildingDict)
	for _, buildingItem in pairs(self._overBuildingItemDict) do
		buildingItem:onManufactureBuildingInfoChange(changeBuildingDict)
	end
end

function RoomManufactureOverView:_onBuildingLevelUp(levelUpBuildingDict)
	if levelUpBuildingDict and levelUpBuildingDict[self._addPopBuildingUid] then
		self:_setAddPopItems(self._addPopBuildingUid, true)
	end
end

local checkPopView = {
	ViewName.RoomManufactureAddPopView,
	ViewName.RoomCritterListView,
	ViewName.RoomManufactureWrongTipView
}

function RoomManufactureOverView:_onViewChange(viewName)
	local refreshPopBlock = false

	for _, popView in ipairs(checkPopView) do
		if viewName == popView then
			refreshPopBlock = true

			break
		end
	end

	if refreshPopBlock then
		self:refreshPopBlock()
	end
end

function RoomManufactureOverView:_focusBuildingItemAddPop(buildingUid, manufactureItem)
	local overBuildingItem = self._overBuildingItemDict[buildingUid]
	local index = overBuildingItem and overBuildingItem:getIndex()

	if not index then
		return
	end

	local contentHeight = recthelper.getHeight(self._contentRect)
	local movePos = (index - 1) * (self._buildingItemHeight + self._layoutSpace)
	local norPos = 1 - movePos / (contentHeight - self._scrollHeight)

	self._scrollbuilding.verticalNormalizedPosition = Mathf.Clamp(norPos, 0, 1)

	ManufactureController.instance:clickSlotItem(buildingUid, nil, true, true, nil, manufactureItem)
end

function RoomManufactureOverView:_editableInitView()
	self._scrollHeight = recthelper.getHeight(self._goscrollbuilding:GetComponent(gohelper.Type_RectTransform))
	self._buildingItemHeight = recthelper.getHeight(self._gobuildingItem:GetComponent(gohelper.Type_RectTransform))
	self._contentRect = self._gobuildingContent:GetComponent(gohelper.Type_RectTransform)

	local contentLayout = self._gobuildingContent:GetComponent(typeof(UnityEngine.UI.VerticalLayoutGroup))

	self._layoutSpace = contentLayout.spacing

	self:clearVar()
end

function RoomManufactureOverView:onUpdateParam()
	return
end

function RoomManufactureOverView:onOpen()
	self:_setBuildingList()
	self:everySecondCall()
	self:refreshPopBlock()
	TaskDispatcher.runRepeat(self.everySecondCall, self, TimeUtil.OneSecond)
end

function RoomManufactureOverView:_setBuildingList()
	self._overBuildingItemDict = {}

	local allPlacedManufactureBuildingList = ManufactureModel.instance:getAllPlacedManufactureBuilding()

	gohelper.CreateObjList(self, self._onSetBuildingItem, allPlacedManufactureBuildingList, self._gobuildingContent, self._gobuildingItem, RoomManufactureOverBuildingItem)
end

function RoomManufactureOverView:_onSetBuildingItem(obj, buildingMO, index)
	obj:setData(buildingMO, index, self)

	self._overBuildingItemDict[buildingMO.uid] = obj
end

function RoomManufactureOverView:_setAddPopItems(buildingUid, forceUpdate)
	if not forceUpdate and self._addPopBuildingUid == buildingUid then
		return
	end

	ManufactureController.instance:setManufactureFormulaItemList(buildingUid)

	self._addPopBuildingUid = buildingUid
end

function RoomManufactureOverView:setViewBuildingUid(buildingUid)
	self.viewContainer:setContainerViewBuildingUid(buildingUid)
end

function RoomManufactureOverView:closePopView()
	ManufactureController.instance:clearSelectedSlotItem()
	ManufactureController.instance:clearSelectCritterSlotItem()
	ManufactureController.instance:closeWrongTipView()
end

function RoomManufactureOverView:refreshPopBlock()
	gohelper.setActive(self._btnpopBlock, false)

	for _, viewName in ipairs(checkPopView) do
		if ViewMgr.instance:isOpen(viewName) then
			gohelper.setActive(self._btnpopBlock, true)

			break
		end
	end
end

function RoomManufactureOverView:everySecondCall()
	for _, buildingItem in pairs(self._overBuildingItemDict) do
		buildingItem:everySecondCall()
	end
end

function RoomManufactureOverView:clearVar()
	self._addPopBuildingUid = nil
end

function RoomManufactureOverView:_onGuideFocusCritter(index)
	local posY = 294 * index - 807

	recthelper.setAnchorY(self._gobuildingContent.transform, math.max(posY, 0))
end

function RoomManufactureOverView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	self:closePopView()
end

function RoomManufactureOverView:onDestroyView()
	self:clearVar()
end

return RoomManufactureOverView
