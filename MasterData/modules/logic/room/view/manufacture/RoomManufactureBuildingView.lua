-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureBuildingView.lua

module("modules.logic.room.view.manufacture.RoomManufactureBuildingView", package.seeall)

local RoomManufactureBuildingView = class("RoomManufactureBuildingView", BaseView)
local DEFAULT_INDEX = 1

function RoomManufactureBuildingView:onInitView()
	self._btnpopBlock = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_popBlock")
	self._imagebuildingIcon = gohelper.findChildImage(self.viewGO, "#go_left/headerInfo/#simage_buildingIcon")
	self._txtmanuName = gohelper.findChildText(self.viewGO, "#go_left/headerInfo/layout/#txt_manuName")
	self._txtlv = gohelper.findChildText(self.viewGO, "#go_left/headerInfo/layout/lv/#txt_lv")
	self._btnupgrade = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/headerInfo/#btn_upgrade")
	self._goupgradeReddot = gohelper.findChild(self.viewGO, "#go_left/headerInfo/#btn_upgrade/#go_reddot")
	self._goswithbtnlayout = gohelper.findChild(self.viewGO, "#go_left/layoutSwitchBtns")
	self._goswithItem = gohelper.findChild(self.viewGO, "#go_left/layoutSwitchBtns/#btn_swithItem")
	self._gocritterInfo = gohelper.findChild(self.viewGO, "#go_left/critterInfo")
	self._gocritterItem = gohelper.findChild(self.viewGO, "#go_left/critterInfo/#go_critterInfoItem")
	self._gomanufacture = gohelper.findChild(self.viewGO, "#go_right/#go_manufacture")
	self._btnaccelerate = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_accelerate")
	self._btnwrong = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_wrong")
	self._gowrongselect = gohelper.findChild(self.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_wrong/#go_select")
	self._gowrongunselect = gohelper.findChild(self.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_wrong/#go_unselect")
	self._btnproduction = gohelper.findChildButtonWithAudio(self.viewGO, "#go_right/#go_manufacture/slotQueue/#btn_production")
	self._goproductionReddot = gohelper.findChild(self.viewGO, "#go_right/#go_manufacture/slotQueue/#btn_production/#go_reddot")
	self._goscrollslot = gohelper.findChild(self.viewGO, "#go_right/#go_manufacture/slotQueue/#scroll_slot")
	self._transscrollslot = self._goscrollslot.transform
	self._scrollslot = self._goscrollslot:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._goslotItemContent = gohelper.findChild(self.viewGO, "#go_right/#go_manufacture/slotQueue/#scroll_slot/viewport/content")
	self._transslotItemContent = self._goslotItemContent.transform
	self._goslotItem = gohelper.findChild(self.viewGO, "#go_right/#go_manufacture/slotQueue/#scroll_slot/viewport/content/#go_slotItem")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_detail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomManufactureBuildingView:addEvents()
	self._btnupgrade:AddClickListener(self._btnupgradeOnClick, self)
	self._btnaccelerate:AddClickListener(self._btnaccelerateOnClick, self)
	self._btnwrong:AddClickListener(self._btnwrongOnClick, self)
	self._btnproduction:AddClickListener(self._btnproductionOnClick, self)
	self._btnpopBlock:AddClickListener(self._btnpopBlockOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
	self.addEventCb(self, RoomController.instance, RoomEvent.ManufactureGuideTweenFinish, self._onManufactureGuideTweenFinish, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.TradeLevelChange, self._onTradeLevelChange, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureBuildingInfoChange, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, self._onChangeSelectedCritterSlotItem, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureReadNewFormula, self._onReadNewFormula, self)
	self.addEventCb(self, RoomMapController.instance, RoomEvent.BuildingLevelUpPush, self._onBuildingLevelUp, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewChange, self)
	NavigateMgr.instance:addEscape(ViewName.RoomManufactureBuildingView, self._onEscape, self)
end

function RoomManufactureBuildingView:removeEvents()
	self._btnupgrade:RemoveClickListener()
	self._btnaccelerate:RemoveClickListener()
	self._btnwrong:RemoveClickListener()
	self._btnproduction:RemoveClickListener()
	self._btnpopBlock:RemoveClickListener()
	self._btndetail:RemoveClickListener()
	self:clearSwitchBtnList()
	self.removeEventCb(self, RoomController.instance, RoomEvent.ManufactureGuideTweenFinish, self._onManufactureGuideTweenFinish, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, self._onManufactureInfoUpdate, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.TradeLevelChange, self._onTradeLevelChange, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, self._onManufactureBuildingInfoChange, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, self._onChangeSelectedCritterSlotItem, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ManufactureReadNewFormula, self._onReadNewFormula, self)
	self.removeEventCb(self, RoomMapController.instance, RoomEvent.BuildingLevelUpPush, self._onBuildingLevelUp, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewChange, self)
end

function RoomManufactureBuildingView:_btndetailOnClick()
	local buildingUid, buildingMO = self:getViewBuilding()

	ManufactureController.instance:openRoomManufactureBuildingDetailView(buildingUid)
end

function RoomManufactureBuildingView:_btnupgradeOnClick()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:openManufactureBuildingLevelUpView(curBuildingUid)
end

function RoomManufactureBuildingView:_btnaccelerateOnClick()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:openManufactureAccelerateView(curBuildingUid)
end

function RoomManufactureBuildingView:_btnwrongOnClick()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:clickWrongBtn(curBuildingUid)
end

function RoomManufactureBuildingView:_btnproductionOnClick(addManuItem)
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:clickSlotItem(curBuildingUid, nil, nil, true, nil, addManuItem)
end

local checkPopView = {
	ViewName.RoomManufactureAddPopView,
	ViewName.RoomCritterListView,
	ViewName.RoomManufactureWrongTipView
}

function RoomManufactureBuildingView:_btnpopBlockOnClick()
	for _, viewName in ipairs(checkPopView) do
		if ViewMgr.instance:isOpen(viewName) then
			self:closePopView()

			break
		end
	end
end

function RoomManufactureBuildingView:_btnswithItemOnClick(param)
	local index = param.index
	local isOnOpen = param.isOnOpen
	local btnItem = self._switchBtnList[index]

	if not btnItem then
		return
	end

	local clickBuildingUid = btnItem.buildingUid
	local curBuildingUid = self:getViewBuilding()

	if curBuildingUid and curBuildingUid == clickBuildingUid then
		return
	end

	self:closePopView()
	self.viewContainer:setContainerViewBuildingUid(clickBuildingUid)

	self._curViewManufactureState = nil

	if not isOnOpen then
		self:_refreshCamera()
	end

	self:refreshSelectedSlot()
	self:refreshSelectedCritterSlot()
	self:_setCritterItem()
	self:_setSlotItems()
	self:_setAddPopItems()
	self:refresh()
end

function RoomManufactureBuildingView:_refreshCamera()
	local curBuildingUid, curBuildingMO = self:getViewBuilding()

	if not curBuildingMO then
		return
	end

	local buildingId = curBuildingMO.buildingId
	local firstCamera = ManufactureConfig.instance:getBuildingCameraIdByIndex(buildingId)
	local roomCamera = RoomCameraController.instance:getRoomCamera()

	if roomCamera and firstCamera then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(curBuildingUid, firstCamera)
	end
end

function RoomManufactureBuildingView:_onManufactureGuideTweenFinish()
	self:_setSlotItems()
end

function RoomManufactureBuildingView:_onManufactureInfoUpdate()
	self:refreshSelectedSlot()
	self:refreshSelectedCritterSlot()
	self:_setCritterItem()
	self:_setSlotItems()
	self:refresh()
end

function RoomManufactureBuildingView:_onTradeLevelChange()
	self:refreshTitle()
	self:_setCritterItem()
end

function RoomManufactureBuildingView:_onManufactureBuildingInfoChange(changeBuildingDict)
	local curBuildingUid = self:getViewBuilding()

	if changeBuildingDict and not changeBuildingDict[curBuildingUid] then
		return
	end

	self:refreshSelectedSlot()
	self:refreshSelectedCritterSlot()
	self:_setCritterItem()
	self:_setSlotItems()
	self:refresh()
end

function RoomManufactureBuildingView:_onChangeSelectedCritterSlotItem()
	local selectedBuildingUid, critterSlotId = ManufactureModel.instance:getSelectedCritterSlot()
	local curBuildingUid = self:getViewBuilding()

	gohelper.setActive(self._gomanufacture, not ((critterSlotId and selectedBuildingUid and selectedBuildingUid == curBuildingUid or nil) and true))
end

function RoomManufactureBuildingView:_onReadNewFormula()
	if not self._newFormulaReddot then
		return
	end

	self._newFormulaReddot:refreshRedDot()
end

function RoomManufactureBuildingView:_onBuildingLevelUp(levelUpBuildingDict)
	local curBuildingUid = self:getViewBuilding()

	if not levelUpBuildingDict or not levelUpBuildingDict[curBuildingUid] then
		return
	end

	self:closePopView()
	self:_setAddPopItems()
	self:_onReadNewFormula()
end

function RoomManufactureBuildingView:_onViewChange(viewName)
	if viewName == ViewName.RoomManufactureWrongTipView then
		self:refreshWrongBtnSelect()
	end
end

function RoomManufactureBuildingView:_onEscape()
	ViewMgr.instance:closeView(ViewName.RoomManufactureBuildingView)
	ManufactureController.instance:resetCameraOnCloseView()
end

function RoomManufactureBuildingView:_editableInitView()
	self:clearVar()
	gohelper.setActive(self._goslotItem, false)
end

function RoomManufactureBuildingView:onUpdateParam()
	self.buildingType = self.viewParam.buildingType
	self.defaultBuildingUid = self.viewParam.defaultBuildingUid

	self:setView()

	if self.viewParam.addManuItem then
		self:_btnproductionOnClick(self.viewParam.addManuItem)
	end
end

function RoomManufactureBuildingView:onOpen()
	self:onUpdateParam()
	self:everySecondCall()
	TaskDispatcher.runRepeat(self.everySecondCall, self, TimeUtil.OneSecond)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
end

function RoomManufactureBuildingView:setView()
	self:_setSwitchBtnGroup()

	local defaultIndex = DEFAULT_INDEX

	if self.defaultBuildingUid then
		for i, btnItem in ipairs(self._switchBtnList) do
			if btnItem.buildingUid == self.defaultBuildingUid then
				defaultIndex = i

				break
			end
		end
	end

	self:_btnswithItemOnClick({
		isOnOpen = true,
		index = defaultIndex
	})
end

function RoomManufactureBuildingView:_setSwitchBtnGroup()
	local buildingList = RoomMapBuildingModel.instance:getBuildingListByType(self.buildingType, true) or {}

	gohelper.CreateObjList(self, self._onSetSwitchBtnItem, buildingList, self._goswithbtnlayout, self._goswithItem)
end

function RoomManufactureBuildingView:_onSetSwitchBtnItem(obj, data, index)
	local btnItem = self:getUserDataTb_()

	btnItem.go = obj
	btnItem.buildingUid = data.uid
	btnItem.goSelect = gohelper.findChild(btnItem.go, "go_select")
	btnItem.goUnselect = gohelper.findChild(btnItem.go, "go_unselect")
	btnItem.goReddot = gohelper.findChild(btnItem.go, "#go_reddot")

	RedDotController.instance:addRedDot(btnItem.goReddot, RedDotEnum.DotNode.ManufactureBuildingCanLevelUp, tonumber(btnItem.buildingUid))

	local manuBuildingIcon = ManufactureConfig.instance:getManufactureBuildingIcon(data.buildingId)

	btnItem.imgSelectIcon = gohelper.findChildImage(btnItem.go, "go_select/image_selecticon")
	btnItem.imgUnselectIcon = gohelper.findChildImage(btnItem.go, "go_unselect/image_unselecticon")

	UISpriteSetMgr.instance:setRoomSprite(btnItem.imgSelectIcon, manuBuildingIcon)
	UISpriteSetMgr.instance:setRoomSprite(btnItem.imgUnselectIcon, manuBuildingIcon)

	btnItem.btn = gohelper.findChildClickWithDefaultAudio(btnItem.go, "clickarea")

	btnItem.btn:AddClickListener(self._btnswithItemOnClick, self, {
		index = index
	})

	self._switchBtnList[index] = btnItem
end

function RoomManufactureBuildingView:_setCritterItem()
	local _, curBuildingMO = self:getViewBuilding()
	local critterCount = 0

	if curBuildingMO then
		critterCount = curBuildingMO:getCanPlaceCritterCount()
	end

	if self._critterItemList then
		local oldCount = #self._critterItemList

		if oldCount and critterCount < oldCount then
			for i = critterCount + 1, oldCount do
				local oldCritterItem = self._critterItemList[i]

				oldCritterItem:reset()
			end
		end

		self._critterItemList = {}

		local critterSlotIdList = {}

		for i = 1, critterCount do
			critterSlotIdList[i] = i - 1
		end

		gohelper.CreateObjList(self, self._onSetCritterItem, critterSlotIdList, self._gocritterInfo, self._gocritterItem, RoomManufactureCritterInfo)
	end
end

function RoomManufactureBuildingView:_onSetCritterItem(obj, data, index)
	self._critterItemList[index] = obj

	obj:setData(data, index, self)
end

function RoomManufactureBuildingView:_setSlotItems()
	local _, curBuildingMO = self:getViewBuilding()

	if not curBuildingMO then
		self:recycleAllSlotItem()

		return
	end

	if self:checkGuide() then
		return
	end

	local buildingId = curBuildingMO.buildingId
	local unlockSlotList = curBuildingMO:getAllUnlockedSlotIdList()
	local totalSlotCount = ManufactureConfig.instance:getBuildingTotalSlotCount(buildingId)

	for i = 1, totalSlotCount do
		local slotItem = self:getSlotItem(i)
		local slotId = unlockSlotList[i]

		slotItem:setData(slotId, i)
	end

	local curSlotCount = #self._slotItemList

	if totalSlotCount < curSlotCount then
		for i = totalSlotCount + 1, curSlotCount do
			local slotItem = self._slotItemList[i]

			self:recycleSlotItem(slotItem)
		end
	end
end

function RoomManufactureBuildingView:_setAddPopItems()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:setManufactureFormulaItemList(curBuildingUid)
end

function RoomManufactureBuildingView:closePopView()
	self:_closeFormulaListView()
	self:_closeCritterListView()
	self:_closeWrongTipView()
end

function RoomManufactureBuildingView:_closeCritterListView()
	ManufactureController.instance:clearSelectCritterSlotItem()
end

function RoomManufactureBuildingView:_closeFormulaListView()
	ManufactureController.instance:clearSelectedSlotItem()
end

function RoomManufactureBuildingView:_closeWrongTipView()
	ManufactureController.instance:closeWrongTipView()
end

function RoomManufactureBuildingView:getSlotItem(index)
	local slotItem = self._slotItemList[index]

	if not slotItem then
		slotItem = self:getSlotItemFromPool()
		self._slotItemList[index] = slotItem
	end

	return slotItem
end

function RoomManufactureBuildingView:getSlotItemFromPool()
	if next(self._slotItemPool) then
		return (table.remove(self._slotItemPool))
	else
		return self:createSlotItem()
	end
end

function RoomManufactureBuildingView:createSlotItem(parentObj)
	local slotItemGo = gohelper.clone(self._goslotItem, parentObj or self._goslotItemContent)

	return (RoomManufactureSlotItem.New(slotItemGo, self))
end

function RoomManufactureBuildingView:recycleSlotItem(slotItem)
	if not slotItem then
		return
	end

	slotItem:reset(true)
	tabletool.removeValue(self._slotItemList, slotItem)
	table.insert(self._slotItemPool, slotItem)
end

function RoomManufactureBuildingView:recycleAllSlotItem()
	if self._slotItemList then
		for _, slotItem in ipairs(self._slotItemList) do
			slotItem:reset(true)
			table.insert(self._slotItemPool, slotItem)
		end
	end

	self._slotItemList = {}
end

function RoomManufactureBuildingView:refresh()
	self:refreshTitle()
	self:refreshSwitchBtns()
	self:refreshSlotItems()
	self:checkManufactureState()
	self:refreshReddot()
	self:refreshWrongBtnShow()
end

function RoomManufactureBuildingView:refreshTitle()
	local name = ""
	local level = 0
	local buildingId, manuBuildingIcon
	local curBuildingUid, curBuildingMO = self:getViewBuilding()

	if curBuildingMO then
		name = curBuildingMO.config.useDesc
		level = curBuildingMO:getLevel()
		manuBuildingIcon = ManufactureConfig.instance:getManufactureBuildingIcon(curBuildingMO.buildingId)
		buildingId = curBuildingMO.buildingId
	end

	self._txtmanuName.text = name

	local maxLevel = ManufactureConfig.instance:getBuildingMaxLevel(buildingId)

	self._txtlv.text = maxLevel <= level and luaLang("lv_max") or formatLuaLang("v1a5_aizila_level", level)

	if manuBuildingIcon then
		UISpriteSetMgr.instance:setRoomSprite(self._imagebuildingIcon, manuBuildingIcon)
	end

	local isMaxLevel = ManufactureModel.instance:isMaxLevel(curBuildingUid)

	gohelper.setActive(self._btnupgrade.gameObject, not isMaxLevel)
end

function RoomManufactureBuildingView:refreshSwitchBtns()
	if not self._switchBtnList then
		return
	end

	local curBuildingUid = self:getViewBuilding()

	for _, btnItem in ipairs(self._switchBtnList) do
		local isSelect = btnItem.buildingUid == curBuildingUid

		gohelper.setActive(btnItem.goSelect, isSelect)
		gohelper.setActive(btnItem.goUnselect, not isSelect)
	end
end

function RoomManufactureBuildingView:refreshSlotItems()
	if self:checkGuide() then
		return
	end

	for _, slotItem in ipairs(self._slotItemList) do
		slotItem:refresh()
	end
end

function RoomManufactureBuildingView:checkManufactureState()
	local _, curBuildingMO = self:getViewBuilding()
	local newManufactureState = false

	if curBuildingMO then
		newManufactureState = curBuildingMO:getManufactureState()
	end

	if self._curViewManufactureState == newManufactureState then
		return
	end

	self._curViewManufactureState = newManufactureState

	local isRunning = self._curViewManufactureState == RoomManufactureEnum.ManufactureState.Running

	gohelper.setActive(self._btnaccelerate.gameObject, isRunning)
end

function RoomManufactureBuildingView:refreshSelectedSlot()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:refreshSelectedSlotId(curBuildingUid)
end

function RoomManufactureBuildingView:refreshSelectedCritterSlot()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:refreshSelectedCritterSlotId(curBuildingUid)
end

function RoomManufactureBuildingView:refreshReddot()
	local curBuildingUid = self:getViewBuilding()

	RedDotController.instance:addRedDot(self._goupgradeReddot, RedDotEnum.DotNode.ManufactureBuildingCanLevelUp, tonumber(curBuildingUid))

	self._newFormulaReddot = RedDotController.instance:addNotEventRedDot(self._goproductionReddot, self.checkNewFormulaReddot, self)
end

function RoomManufactureBuildingView:checkNewFormulaReddot()
	local curBuildingUid = self:getViewBuilding()

	return ManufactureModel.instance:hasNewManufactureFormula(curBuildingUid)
end

function RoomManufactureBuildingView:refreshWrongBtnShow()
	local curBuildingUid = self:getViewBuilding()
	local tipItemList = ManufactureModel.instance:getManufactureWrongTipItemList(curBuildingUid)
	local isShow = #tipItemList > 0

	if isShow then
		self:refreshWrongBtnSelect()
	end

	gohelper.setActive(self._btnwrong, isShow)
end

function RoomManufactureBuildingView:refreshWrongBtnSelect()
	local isOpen = ViewMgr.instance:isOpen(ViewName.RoomManufactureWrongTipView)

	gohelper.setActive(self._gowrongselect, isOpen)
	gohelper.setActive(self._gowrongunselect, not isOpen)
end

function RoomManufactureBuildingView:everySecondCall()
	for _, slotItem in ipairs(self._slotItemList) do
		slotItem:everySecondCall()
	end
end

function RoomManufactureBuildingView:getViewBuilding()
	local viewBuildingUid, viewBuildingMO = self.viewContainer:getContainerViewBuilding()

	return viewBuildingUid, viewBuildingMO
end

function RoomManufactureBuildingView:clearVar()
	self.buildingType = nil
	self.defaultBuildingUid = nil

	self:clearSwitchBtnList()

	self._curViewManufactureState = nil

	self:clearSlotPool()
	self:clearSlotItemList()
end

function RoomManufactureBuildingView:clearSwitchBtnList()
	if self._switchBtnList then
		for _, switchBtn in ipairs(self._switchBtnList) do
			switchBtn.btn:RemoveClickListener()
			gohelper.destroy(switchBtn.go)
		end
	end

	self._switchBtnList = {}
end

function RoomManufactureBuildingView:clearSlotPool()
	if self._slotItemPool then
		for _, slotItem in ipairs(self._slotItemPool) do
			slotItem:destroy()
		end
	end

	self._slotItemPool = {}
end

function RoomManufactureBuildingView:clearSlotItemList()
	if self._slotItemList then
		for _, slotItem in ipairs(self._slotItemList) do
			slotItem:destroy()
		end
	end

	self._slotItemList = {}
end

function RoomManufactureBuildingView:checkGuide()
	local guideId = GuideModel.instance:getLockGuideId()
	local hasPlay = false

	if guideId == 414 then
		for i, v in ipairs(self._slotItemList) do
			if v:checkPlayGuideTween() then
				hasPlay = true
			end
		end
	end

	return hasPlay
end

function RoomManufactureBuildingView:onClose()
	TaskDispatcher.cancelTask(self.everySecondCall, self)
	self:closePopView()
	ManufactureController.instance:dispatchEvent(ManufactureEvent.ManufactureBuildingViewChange)
end

function RoomManufactureBuildingView:onDestroyView()
	self:clearVar()
end

return RoomManufactureBuildingView
