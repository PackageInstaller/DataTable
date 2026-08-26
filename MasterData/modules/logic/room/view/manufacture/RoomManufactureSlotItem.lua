-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureSlotItem.lua

module("modules.logic.room.view.manufacture.RoomManufactureSlotItem", package.seeall)

local RoomManufactureSlotItem = class("RoomManufactureSlotItem", UserDataDispose)
local FIRST_INDEX = 1
local IN_POOL_NAME = "slotItem"

function RoomManufactureSlotItem:ctor(go, parentView)
	self:__onInit()

	self.go = go
	self.trans = self.go.transform
	self.parentView = parentView
	self._curViewSlotState = nil

	if self._editableInitView then
		self:_editableInitView()
	end

	self:addEventListeners()
end

function RoomManufactureSlotItem:_editableInitView()
	self._gocontent = gohelper.findChild(self.go, "content")
	self._golocked = gohelper.findChild(self.go, "content/#go_locked")
	self._gounlocked = gohelper.findChild(self.go, "content/#go_unlocked")
	self._goadd = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_add")
	self._goitem = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_item")
	self._imgquality = gohelper.findChildImage(self.go, "content/#go_unlocked/slotItemHead/#go_item/#image_quality")
	self._txtitemName = gohelper.findChildText(self.go, "content/#go_unlocked/slotItemHead/#go_item/#txt_itemName")
	self._gowrong = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_wrong")
	self._gowrongwait = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_wait")
	self._gowrongstop = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_stop")
	self._goget = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_get")
	self._btngetclick = gohelper.findChildClickWithDefaultAudio(self.go, "content/#go_unlocked/slotItemHead/#go_get")
	self._goitemBar = gohelper.findChild(self.go, "content/#go_unlocked/#go_itemBar")
	self._gowait = gohelper.findChild(self.go, "content/#go_unlocked/#go_itemBar/wait")
	self._gopause = gohelper.findChild(self.go, "content/#go_unlocked/#go_itemBar/pause")
	self._iconwrongstatus = gohelper.findChildImage(self.go, "content/#go_unlocked/#go_itemBar/pause/#simage_status")
	self._txtwrongstatus = gohelper.findChildText(self.go, "content/#go_unlocked/#go_itemBar/pause/#simage_status/#txt_status")
	self._simagepausebarValue = gohelper.findChildImage(self.go, "content/#go_unlocked/#go_itemBar/pause/#simage_totalBarValue")
	self._txtpauseTime = gohelper.findChildText(self.go, "content/#go_unlocked/#go_itemBar/pause/#go_totalTime/#txt_totalTime")
	self._gorunning = gohelper.findChild(self.go, "content/#go_unlocked/#go_itemBar/producing")
	self._simagerunningbarValue = gohelper.findChildImage(self.go, "content/#go_unlocked/#go_itemBar/producing/#simage_totalBarValue")
	self._txtrunningTime = gohelper.findChildText(self.go, "content/#go_unlocked/#go_itemBar/producing/#go_totalTime/#txt_totalTime")
	self._goselected = gohelper.findChild(self.go, "content/#go_unlocked/#go_selected")
	self._goAddEff = gohelper.findChild(self.go, "content/#add_effect")
	self._btnremove = gohelper.findChildButtonWithAudio(self.go, "#btn_remove")
	self._gobtnremove = self._btnremove.gameObject
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_click")
	self._btnmove = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_move")
	self._gobtnmove = self._btnmove.gameObject
	self._gomoveup = gohelper.findChild(self.go, "#btn_move/#go_up")
	self._gomovedown = gohelper.findChild(self.go, "#btn_move/#go_down")

	self:reset()
end

function RoomManufactureSlotItem:addEventListeners()
	self._btngetclick:AddClickListener(self._onClick, self)
	self._btnclick:AddClickListener(self._onClick, self)
	self._btnremove:AddClickListener(self._btnremoveOnClick, self)
	self._btnmove:AddClickListener(self._btnmoveOnClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, self._onChangeSelectedSlotItem, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, self._onAddManufactureItem, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewChange, self)
end

function RoomManufactureSlotItem:removeEventListeners()
	self._btngetclick:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self._btnremove:RemoveClickListener()
	self._btnmove:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.ChangeSelectedSlotItem, self._onChangeSelectedSlotItem, self)
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, self._onAddManufactureItem, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewChange, self)
end

function RoomManufactureSlotItem:_onClick()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:clickSlotItem(curBuildingUid, self.slotId, nil, nil, self.index)
end

function RoomManufactureSlotItem:_btnremoveOnClick()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:clickRemoveSlotManufactureItem(curBuildingUid, self.slotId)
end

function RoomManufactureSlotItem:_btnmoveOnClick()
	local curBuildingUid = self:getViewBuilding()

	ManufactureController.instance:moveManufactureItem(curBuildingUid, self.slotId, self._isShowDown)
end

function RoomManufactureSlotItem:_onChangeSelectedSlotItem()
	self:refreshSelected()
end

function RoomManufactureSlotItem:_onAddManufactureItem(playEffDict)
	if not playEffDict then
		return
	end

	local curBuildingUid = self:getViewBuilding()
	local slotId = self:getSlotId()

	if playEffDict[curBuildingUid] and playEffDict[curBuildingUid][slotId] then
		self:playAddManufactureItemEff()
	end
end

function RoomManufactureSlotItem:_onViewChange(viewName)
	if viewName ~= ViewName.RoomManufactureAddPopView then
		return
	end

	self:checkBtnShow()
end

function RoomManufactureSlotItem:playAddManufactureItemEff()
	gohelper.setActive(self._goAddEff, false)
	gohelper.setActive(self._goAddEff, true)
end

function RoomManufactureSlotItem:getViewBuilding()
	local viewBuildingUid, viewBuildingMO

	if self.parentView then
		viewBuildingUid, viewBuildingMO = self.parentView:getViewBuilding()
	end

	return viewBuildingUid, viewBuildingMO
end

function RoomManufactureSlotItem:getSlotId()
	return self.slotId
end

function RoomManufactureSlotItem:getItemHeight()
	return (recthelper.getHeight(self.trans))
end

function RoomManufactureSlotItem:setData(slotId, index)
	self:closeGuideTween()

	self.slotId = slotId
	self.index = index
	self.go.name = tostring(index)

	self:refresh()
	gohelper.setActive(self._goAddEff, false)
	gohelper.setActive(self.go, true)
end

function RoomManufactureSlotItem:refresh()
	self:checkState()
	self:refreshMoveBtn()
	self:refreshManufactureItem()
	self:refreshTime()
	self:refreshSelected()
	self:checkBtnShow()
	self:refreshWrong()
end

function RoomManufactureSlotItem:checkState()
	local _, curBuildingMO = self:getViewBuilding()
	local newSlotState = curBuildingMO and curBuildingMO:getSlotState(self.slotId) or false

	if self._curViewSlotState == newSlotState then
		return
	end

	self._curViewSlotState = newSlotState

	local isNone = false
	local isRunning = false
	local isWait = false
	local isStop = false
	local isComplete = false
	local isLocked = not self._curViewSlotState or self._curViewSlotState == RoomManufactureEnum.SlotState.Locked

	if not isLocked then
		isNone = self._curViewSlotState == RoomManufactureEnum.SlotState.None
		isRunning = self._curViewSlotState == RoomManufactureEnum.SlotState.Running
		isWait = self._curViewSlotState == RoomManufactureEnum.SlotState.Wait
		isStop = self._curViewSlotState == RoomManufactureEnum.SlotState.Stop
		isComplete = self._curViewSlotState == RoomManufactureEnum.SlotState.Complete
	end

	gohelper.setActive(self._golocked, isLocked)
	gohelper.setActive(self._gounlocked, not isLocked)
	gohelper.setActive(self._goadd, isNone)

	local isShowItem = isRunning or isWait or isStop or isComplete

	gohelper.setActive(self._goitem, isShowItem)
	gohelper.setActive(self._goget, isComplete)
	gohelper.setActive(self._goitemBar, isRunning or isWait or isStop)
	gohelper.setActive(self._gowait, isWait)
	gohelper.setActive(self._gorunning, isRunning)
	gohelper.setActive(self._gopause, isStop)
	self:refreshTime()
	self:checkBtnShow()
end

function RoomManufactureSlotItem:refreshManufactureItem()
	local _, curBuildingMO = self:getViewBuilding()
	local manufactureItemId = curBuildingMO and curBuildingMO:getSlotManufactureItemId(self.slotId)

	if not manufactureItemId or manufactureItemId == 0 then
		return
	end

	local itemId = ManufactureConfig.instance:getItemId(manufactureItemId)

	if not itemId then
		return
	end

	if not self._itemIcon then
		self._itemIcon = IconMgr.instance:getCommonItemIcon(self._goitem)

		self._itemIcon:isEnableClick(false)
		self._itemIcon:isShowQuality(false)
	end

	local batchIconPath = ManufactureConfig.instance:getBatchIconPath(manufactureItemId)

	self._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, itemId, nil, nil, nil, {
		specificIcon = batchIconPath
	})

	local itemName = ManufactureConfig.instance:getManufactureItemName(manufactureItemId)

	self._txtitemName.text = itemName or ""

	local rare = self._itemIcon:getRare()
	local qualityImg = RoomManufactureEnum.RareImageMap[rare]

	UISpriteSetMgr.instance:setCritterSprite(self._imgquality, qualityImg)
end

function RoomManufactureSlotItem:refreshTime()
	local totalProgress = 0
	local strRemainTime = ""
	local _, curBuildingMO = self:getViewBuilding()

	if curBuildingMO then
		totalProgress = curBuildingMO:getSlotProgress(self.slotId)
		strRemainTime = curBuildingMO:getSlotRemainStrTime(self.slotId)
	end

	self._txtrunningTime.text = strRemainTime
	self._txtpauseTime.text = strRemainTime

	self:_setBarVal(totalProgress)
end

function RoomManufactureSlotItem:_setBarVal(val)
	self._simagerunningbarValue.fillAmount = val
	self._simagepausebarValue.fillAmount = val
	self.totalProgress = val
end

function RoomManufactureSlotItem:refreshMoveBtn()
	self._isShowDown = self.index == FIRST_INDEX

	gohelper.setActive(self._gomoveup, not self._isShowDown)
	gohelper.setActive(self._gomovedown, self._isShowDown)
end

function RoomManufactureSlotItem:refreshSelected()
	local isSelected = false

	if self.slotId then
		local selectedBuildingUid, selectedSlot = ManufactureModel.instance:getSelectedSlot()
		local curBuildingUid = self:getViewBuilding()

		if selectedBuildingUid and curBuildingUid == selectedBuildingUid then
			isSelected = true
		end
	end

	gohelper.setActive(self._goselected, isSelected)
end

function RoomManufactureSlotItem:checkBtnShow()
	local isShowRemoveBtn = false
	local isShowMoveBtn = false
	local _, curBuildingMO = self:getViewBuilding()
	local isShowAddPop = ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView)

	if curBuildingMO and isShowAddPop and self._curViewSlotState ~= RoomManufactureEnum.SlotState.Complete then
		local manufactureItem = curBuildingMO:getSlotManufactureItemId(self.slotId)

		if manufactureItem and manufactureItem ~= 0 then
			isShowRemoveBtn = true

			local count = curBuildingMO:getOccupySlotCount(true)

			isShowMoveBtn = count > FIRST_INDEX
		end
	end

	gohelper.setActive(self._gobtnremove, isShowRemoveBtn)
	gohelper.setActive(self._gobtnmove, isShowMoveBtn)
end

function RoomManufactureSlotItem:refreshWrong()
	local curBuildingUid = self:getViewBuilding()
	local wrongTxt = ""
	local wrongIcon = RoomManufactureEnum.DefaultPauseIcon
	local wrongType = ManufactureModel.instance:getManufactureWrongType(curBuildingUid, self.slotId)

	if wrongType then
		local displaySetting = RoomManufactureEnum.ManufactureWrongDisplay[wrongType]

		if displaySetting then
			wrongIcon = displaySetting.icon
			wrongTxt = luaLang(displaySetting.desc)
		end

		local isWaitMat = wrongType == RoomManufactureEnum.ManufactureWrongType.WaitPreMat

		gohelper.setActive(self._gowrongwait, isWaitMat)
		gohelper.setActive(self._gowrongstop, not isWaitMat)
	end

	self._txtwrongstatus.text = wrongTxt

	if not string.nilorempty(wrongIcon) then
		UISpriteSetMgr.instance:setRoomSprite(self._iconwrongstatus, wrongIcon)
	end

	gohelper.setActive(self._iconwrongstatus, wrongIcon)
	gohelper.setActive(self._gowrong, wrongType)
end

function RoomManufactureSlotItem:checkPlayGuideTween()
	if self._guideTweenId then
		return true
	end

	local _, curBuildingMO = self:getViewBuilding()
	local newSlotState = curBuildingMO and curBuildingMO:getSlotState(self.slotId, true)
	local playAnim = self._curViewSlotState == RoomManufactureEnum.SlotState.Running and newSlotState == RoomManufactureEnum.SlotState.Complete

	if playAnim then
		self._curViewSlotState = -1

		if not self.totalProgress then
			local endVal = 1

			self._guideTweenId = ZProj.TweenHelper.DOTweenFloat(self.totalProgress, endVal, 1, self._setBarVal, self._onGuideTweenFinish, self, nil, EaseType.Linear)
		end
	end

	return playAnim
end

function RoomManufactureSlotItem:closeGuideTween()
	if self._guideTweenId then
		ZProj.TweenHelper.KillById(self._guideTweenId)

		self._guideTweenId = nil
	end
end

function RoomManufactureSlotItem:_onGuideTweenFinish()
	self:closeGuideTween()
	RoomController.instance:dispatchEvent(RoomEvent.ManufactureGuideTweenFinish)
end

function RoomManufactureSlotItem:everySecondCall()
	if self._curViewSlotState == RoomManufactureEnum.SlotState.Running then
		self:refreshTime()
	end
end

function RoomManufactureSlotItem:reset()
	self.slotId = nil
	self.index = nil
	self._curViewSlotState = nil
	self._isShowDown = nil
	self.go.name = IN_POOL_NAME

	gohelper.setActive(self._goAddEff, false)
	gohelper.setActive(self.go, false)
end

function RoomManufactureSlotItem:destroy()
	self:closeGuideTween()
	self:removeEventListeners()
	self:reset()
	self:__onDispose()
end

return RoomManufactureSlotItem
