-- chunkname: @modules/logic/room/view/manufacture/RoomManufactureOverSlotItem.lua

module("modules.logic.room.view.manufacture.RoomManufactureOverSlotItem", package.seeall)

local RoomManufactureOverSlotItem = class("RoomManufactureOverSlotItem", UserDataDispose)
local FIRST_INDEX = 1
local IN_POOL_NAME = "slotItem"
local OFFSET = 20

function RoomManufactureOverSlotItem:ctor(go, parent)
	self:__onInit()

	self.go = go
	self.trans = self.go.transform
	self.parent = parent

	if self._editableInitView then
		self:_editableInitView()
	end

	self:addEventListeners()
end

function RoomManufactureOverSlotItem:_editableInitView()
	self._gocontent = gohelper.findChild(self.go, "content")
	self._golocked = gohelper.findChild(self.go, "content/#go_locked")
	self._gounlocked = gohelper.findChild(self.go, "content/#go_unlocked")
	self._imgquality = gohelper.findChildImage(self.go, "content/#go_unlocked/slotItemHead/#image_quality")
	self._goadd = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_add")
	self._goitem = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_item")
	self._gowrong = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_wrong")
	self._gowrongwait = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_wait")
	self._gowrongstop = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_wrong/#go_stop")
	self._goget = gohelper.findChild(self.go, "content/#go_unlocked/slotItemHead/#go_get")
	self._gopause = gohelper.findChild(self.go, "content/#go_unlocked/pause")
	self._iconwrongstatus = gohelper.findChildImage(self.go, "content/#go_unlocked/pause/#simage_status")
	self._imagepausebarValue = gohelper.findChildImage(self.go, "content/#go_unlocked/pause/#simage_barValue")
	self._gorunning = gohelper.findChild(self.go, "content/#go_unlocked/producing")
	self._imagerunningbarValue = gohelper.findChildImage(self.go, "content/#go_unlocked/producing/#simage_barValue")
	self._txtrunningTime = gohelper.findChildText(self.go, "content/#go_unlocked/producing/#txt_time")
	self._goselected = gohelper.findChild(self.go, "content/#go_unlocked/#go_selected")
	self._goAddEff = gohelper.findChild(self.go, "content/#go_unlocked/#add")
	self._btnremove = gohelper.findChildButtonWithAudio(self.go, "content/#btn_remove")
	self._gobtnremove = self._btnremove.gameObject
	self._btnclick = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_click")
	self._btnmove = gohelper.findChildClickWithDefaultAudio(self.go, "#btn_move")
	self._gobtnmove = self._btnmove.gameObject
	self._gomoveup = gohelper.findChild(self.go, "#btn_move/#go_up")
	self._gomovedown = gohelper.findChild(self.go, "#btn_move/#go_down")

	self:reset()
end

function RoomManufactureOverSlotItem:addEventListeners()
	self._btnclick:AddClickListener(self._onClick, self)
	self._btnremove:AddClickListener(self._btnremoveOnClick, self)
	self._btnmove:AddClickListener(self._btnmoveOnClick, self)
	self.addEventCb(self, ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, self._onAddManufactureItem, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function RoomManufactureOverSlotItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btnremove:RemoveClickListener()
	self._btnmove:RemoveClickListener()
	self.removeEventCb(self, ManufactureController.instance, ManufactureEvent.PlayAddManufactureItemEff, self._onAddManufactureItem, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onViewChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function RoomManufactureOverSlotItem:_onClick()
	local belongBuildingUid = self:getBelongBuilding()

	ManufactureController.instance:clickSlotItem(belongBuildingUid, self.slotId, true, nil, self.index)
end

function RoomManufactureOverSlotItem:_btnremoveOnClick()
	local belongBuildingUid = self:getBelongBuilding()

	ManufactureController.instance:clickRemoveSlotManufactureItem(belongBuildingUid, self.slotId)
end

function RoomManufactureOverSlotItem:_btnmoveOnClick()
	local belongBuildingUid = self:getBelongBuilding()

	ManufactureController.instance:moveManufactureItem(belongBuildingUid, self.slotId, self._isShowDown)
end

function RoomManufactureOverSlotItem:onChangeSelectedSlotItem()
	self:refreshSelected()
	self:checkBtnShow()
end

function RoomManufactureOverSlotItem:_onAddManufactureItem(playEffDict)
	if not playEffDict then
		return
	end

	local belongBuildingUid = self:getBelongBuilding()
	local slotId = self:getSlotId()

	if playEffDict[belongBuildingUid] and playEffDict[belongBuildingUid][slotId] then
		self:playAddManufactureItemEff()
	end
end

function RoomManufactureOverSlotItem:_onCloseView(viewName)
	if viewName == ViewName.RoomOneKeyView and self._playEffWaitCloseView then
		self:playAddManufactureItemEff()
	end

	self:_onViewChange(viewName)
end

function RoomManufactureOverSlotItem:_onViewChange(viewName)
	if viewName ~= ViewName.RoomManufactureAddPopView then
		return
	end

	self:checkBtnShow()
end

function RoomManufactureOverSlotItem:getBelongBuilding()
	if not self.parent then
		return
	end

	local belongBuildingUid, belongBuildingMO = self.parent:getViewBuilding()

	return belongBuildingUid, belongBuildingMO
end

function RoomManufactureOverSlotItem:getSlotId()
	return self.slotId
end

function RoomManufactureOverSlotItem:getItemWidth()
	return (recthelper.getWidth(self.trans))
end

function RoomManufactureOverSlotItem:setData(slotId, index)
	self.slotId = slotId
	self.index = index
	self._playEffWaitCloseView = false

	local name = ""
	local _, belongBuildingMO = self:getBelongBuilding()
	local buildingId, priority

	if belongBuildingMO then
		buildingId = belongBuildingMO.buildingId
		priority = belongBuildingMO:getSlotPriority(self.slotId)
	end

	name = priority and string.format("bId-%s_id-%s_i-%s_p-%s", buildingId, self.slotId, self.index, priority) or string.format("bId-%s_id-%s_i-%s", buildingId, self.slotId, self.index)

	self:setPos()

	self.go.name = name

	self:refresh()
	self:checkBtnShow()
	gohelper.setActive(self.go, true)
end

function RoomManufactureOverSlotItem:setPos(pos)
	local posX = 0
	local posY = 0

	if pos then
		posX = pos.x
		posY = pos.y
	else
		local itemWidth = self:getItemWidth()

		posX = (itemWidth + RoomManufactureEnum.OverviewSlotItemSpace) * (self.index - 1) + itemWidth / 2
	end

	transformhelper.setLocalPosXY(self.trans, posX + OFFSET, posY)
end

function RoomManufactureOverSlotItem:refresh()
	self:checkState()
	self:refreshMoveBtn()
	self:refreshManufactureItem()
	self:refreshTime()
	self:refreshSelected()
	self:checkBtnShow()
	self:refreshWrong()
end

function RoomManufactureOverSlotItem:checkState()
	local _, belongBuildingMO = self:getBelongBuilding()
	local newSlotState = belongBuildingMO and belongBuildingMO:getSlotState(self.slotId) or false

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
	gohelper.setActive(self._gorunning, isRunning)
	gohelper.setActive(self._gopause, isStop)
	self:refreshTime()
end

function RoomManufactureOverSlotItem:refreshManufactureItem()
	local _, belongBuildingMO = self:getBelongBuilding()
	local manufactureItemId = belongBuildingMO and belongBuildingMO:getSlotManufactureItemId(self.slotId)

	if not manufactureItemId or manufactureItemId == 0 then
		return
	end

	if manufactureItemId then
		::label_19_0::

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

		local rare = self._itemIcon:getRare()
		local qualityImg = RoomManufactureEnum.RareImageMap[rare]

		UISpriteSetMgr.instance:setCritterSprite(self._imgquality, qualityImg)
	end
end

function RoomManufactureOverSlotItem:refreshTime()
	local strRemainTime = ""
	local totalProgress = 0
	local _, belongBuildingMO = self:getBelongBuilding()

	if belongBuildingMO then
		totalProgress = belongBuildingMO:getSlotProgress(self.slotId)
		strRemainTime = belongBuildingMO:getSlotRemainStrTime(self.slotId)
	end

	self._imagepausebarValue.fillAmount = totalProgress
	self._imagerunningbarValue.fillAmount = totalProgress
	self._txtrunningTime.text = strRemainTime
end

function RoomManufactureOverSlotItem:refreshMoveBtn()
	self._isShowDown = self.index == FIRST_INDEX

	gohelper.setActive(self._gomoveup, not self._isShowDown)
	gohelper.setActive(self._gomovedown, self._isShowDown)
end

function RoomManufactureOverSlotItem:refreshSelected()
	local isSelected = false

	if self.slotId then
		local selectedBuildingUid, selectedSlot = ManufactureModel.instance:getSelectedSlot()
		local belongBuildingUid = self:getBelongBuilding()

		if selectedBuildingUid and belongBuildingUid == selectedBuildingUid then
			isSelected = true
		end
	end

	gohelper.setActive(self._goselected, isSelected)
end

function RoomManufactureOverSlotItem:checkBtnShow()
	local isShowRemoveBtn = false
	local isShowMoveBtn = false
	local belongBuildingUid, belongBuildingMO = self:getBelongBuilding()
	local isShowAddPop = ViewMgr.instance:isOpen(ViewName.RoomManufactureAddPopView)

	if belongBuildingMO and isShowAddPop and self._curViewSlotState ~= RoomManufactureEnum.SlotState.Complete then
		local selectedBuildingUid = ManufactureModel.instance:getSelectedSlot()

		if selectedBuildingUid and belongBuildingUid == selectedBuildingUid then
			local manufactureItem = belongBuildingMO:getSlotManufactureItemId(self.slotId)

			if manufactureItem and manufactureItem ~= 0 then
				isShowRemoveBtn = true

				local count = belongBuildingMO:getOccupySlotCount(true)

				isShowMoveBtn = count > FIRST_INDEX
			end
		end
	end

	gohelper.setActive(self._gobtnremove, isShowRemoveBtn)
	gohelper.setActive(self._gobtnmove, isShowMoveBtn)
end

function RoomManufactureOverSlotItem:refreshWrong()
	local belongBuildingUid = self:getBelongBuilding()
	local wrongIcon = RoomManufactureEnum.DefaultPauseIcon
	local wrongType = ManufactureModel.instance:getManufactureWrongType(belongBuildingUid, self.slotId)

	if wrongType then
		local displaySetting = RoomManufactureEnum.ManufactureWrongDisplay[wrongType]

		if displaySetting then
			wrongIcon = displaySetting.icon
		end

		local isWaitMat = wrongType == RoomManufactureEnum.ManufactureWrongType.WaitPreMat

		gohelper.setActive(self._gowrongwait, isWaitMat)
		gohelper.setActive(self._gowrongstop, not isWaitMat)
	end

	if not string.nilorempty(wrongIcon) then
		UISpriteSetMgr.instance:setRoomSprite(self._iconwrongstatus, wrongIcon)
	end

	gohelper.setActive(self._iconwrongstatus, wrongIcon)
	gohelper.setActive(self._gowrong, wrongType)
end

function RoomManufactureOverSlotItem:playAddManufactureItemEff()
	local isOpenOneKeyView = ViewMgr.instance:isOpen(ViewName.RoomOneKeyView)

	if isOpenOneKeyView then
		self._playEffWaitCloseView = true
	else
		gohelper.setActive(self._goAddEff, false)
		gohelper.setActive(self._goAddEff, true)

		self._playEffWaitCloseView = false
	end
end

function RoomManufactureOverSlotItem:everySecondCall()
	if self._curViewSlotState == RoomManufactureEnum.SlotState.Running then
		self:refreshTime()
	end
end

function RoomManufactureOverSlotItem:reset()
	self.slotId = nil
	self.index = nil
	self._curViewSlotState = nil
	self._isShowDown = nil
	self.go.name = IN_POOL_NAME
	self._playEffWaitCloseView = false

	gohelper.setActive(self.go, false)
end

function RoomManufactureOverSlotItem:destroy()
	self:removeEventListeners()
	self:reset()
	self:__onDispose()
end

return RoomManufactureOverSlotItem
