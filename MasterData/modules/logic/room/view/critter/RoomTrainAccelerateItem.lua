-- chunkname: @modules/logic/room/view/critter/RoomTrainAccelerateItem.lua

module("modules.logic.room.view.critter.RoomTrainAccelerateItem", package.seeall)

local RoomTrainAccelerateItem = class("RoomTrainAccelerateItem", ListScrollCellExtend)
local MIN_CAN_NOT_USE_COUNT = 1

function RoomTrainAccelerateItem:onInitView()
	self._goitem = gohelper.findChild(self.viewGO, "#go_item")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_name")
	self._gouse = gohelper.findChild(self.viewGO, "#go_use")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#btn_sub")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "#go_use/valuebg/#input_value")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#btn_max")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_use/hasCount/#simage_icon")
	self._txthas = gohelper.findChildText(self.viewGO, "#go_use/hasCount/#txt_has")
	self._btnuse = gohelper.findChildButtonWithAudio(self.viewGO, "#go_use/#btn_use")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTrainAccelerateItem:addEvents()
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btnuse:AddClickListener(self._btnuseOnClick, self)
end

function RoomTrainAccelerateItem:removeEvents()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btnuse:RemoveClickListener()
end

function RoomTrainAccelerateItem:_btnminOnClick()
	self:changeCount(MIN_CAN_NOT_USE_COUNT)
end

function RoomTrainAccelerateItem:_btnsubOnClick()
	self:changeCount(self._count - 1)
end

function RoomTrainAccelerateItem:_onInputValueChange(value)
	local count = tonumber(value)

	count = count or MIN_CAN_NOT_USE_COUNT

	self:changeCount(count)
end

function RoomTrainAccelerateItem:_btnaddOnClick()
	self:changeCount(self._count + 1)
end

function RoomTrainAccelerateItem:_btnmaxOnClick()
	local maxCount = self:getMaxCount()

	self:changeCount(maxCount)
end

function RoomTrainAccelerateItem:_btnuseOnClick()
	local checkResult = self:checkCount()

	if checkResult then
		local cdTime = self._critterMO.trainInfo:getCurCdTime()

		if cdTime < self._count * self._accelerateTime then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainFastForwardExceed, MsgBoxEnum.BoxType.Yes_No, self._yesToSendFasetForward, nil, nil, self, nil, nil)

			return
		end

		RoomCritterController.instance:sendFastForwardTrain(self._critterUid, self._itemId, self._count)
	else
		GameFacade.showToast(ToastEnum.RoomManufactureAccelerateCount)
	end
end

function RoomTrainAccelerateItem:_yesToSendFasetForward()
	local checkResult = self:checkCount()

	if checkResult then
		RoomCritterController.instance:sendFastForwardTrain(self._critterUid, self._itemId, self._count)
	end
end

function RoomTrainAccelerateItem:_editableInitView()
	return
end

function RoomTrainAccelerateItem:_editableAddEvents()
	if self._view and self._view.viewContainer then
		self._view.viewContainer:registerCallback(CritterEvent.UITrainCdTime, self._opTranCdTimeUpdate, self)
		self._view.viewContainer:registerCallback(CritterEvent.FastForwardTrainReply, self._opFastForwardTrainReply, self)
	end
end

function RoomTrainAccelerateItem:_editableRemoveEvents()
	if self._view and self._view.viewContainer then
		self._view.viewContainer:unregisterCallback(CritterEvent.UITrainCdTime, self._opTranCdTimeUpdate, self)
		self._view.viewContainer:unregisterCallback(CritterEvent.FastForwardTrainReply, self._opFastForwardTrainReply, self)
	end
end

function RoomTrainAccelerateItem:onUpdateMO(mo)
	return
end

function RoomTrainAccelerateItem:onSelect(isSelect)
	return
end

function RoomTrainAccelerateItem:onDestroyView()
	return
end

function RoomTrainAccelerateItem:_opTranCdTimeUpdate()
	local useMax = self:getUseMaxCount()

	if useMax < self._count then
		-- block empty
	end
end

function RoomTrainAccelerateItem:_opFastForwardTrainReply()
	self:changeCount(MIN_CAN_NOT_USE_COUNT)
	self:refreshCount()
end

function RoomTrainAccelerateItem:setData(critterUid, itemId)
	self._critterUid = critterUid
	self._itemId = itemId
	self._itemCfg = ItemConfig.instance:getItemCo(itemId)
	self._accelerateTime = 0

	if self._itemCfg then
		self._accelerateTime = tonumber(self._itemCfg.effect)
	end

	self._critterMO = CritterModel.instance:getCritterMOByUid(self._critterUid)

	self:setItem()
	self:changeCount(MIN_CAN_NOT_USE_COUNT)
end

function RoomTrainAccelerateItem:setItem()
	if not self._itemId then
		return
	end

	self._itemIcon = self._itemIcon or IconMgr.instance:getCommonItemIcon(self._goitem)

	local _, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, self._itemId, true)

	self._simageicon:LoadImage(icon)
	self._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, self._itemId)

	self._txtname.text = ItemConfig.instance:getItemNameById(self._itemId)
end

function RoomTrainAccelerateItem:changeCount(count, notify)
	local maxCount = self:getMaxCount()
	local useMax = self:getUseMaxCount()

	if useMax < count then
		count = useMax
	end

	if count < MIN_CAN_NOT_USE_COUNT then
		count = MIN_CAN_NOT_USE_COUNT
	end

	if maxCount < count then
		count = maxCount
	end

	self._count = count

	if notify then
		self._inputvalue:SetText(count)
	else
		self._inputvalue:SetTextWithoutNotify(tostring(count))
	end

	self:refreshCount()

	if self._view then
		self._view:setPreviewForwardTime(self._count * self._accelerateTime)
	end
end

function RoomTrainAccelerateItem:refreshCount()
	local maxCount = self:getMaxCount()

	self._txthas.text = string.format("%s/%s", self._count, maxCount)

	local isCanUse = self:checkCount()

	ZProj.UGUIHelper.SetGrayscale(self._btnuse.gameObject, not isCanUse)
end

function RoomTrainAccelerateItem:getUseMaxCount()
	if not self._accelerateTime or self._accelerateTime <= 0 then
		return 0
	end

	if self._critterMO then
		local cdTime = self._critterMO.trainInfo:getCurCdTime()

		return math.ceil(cdTime / self._accelerateTime)
	end

	return 0
end

function RoomTrainAccelerateItem:getMaxCount()
	return (ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, self._itemId))
end

function RoomTrainAccelerateItem:checkCount()
	local maxCount = self:getMaxCount()

	return (self._count and MIN_CAN_NOT_USE_COUNT <= self._count and maxCount >= self._count or nil) and true
end

return RoomTrainAccelerateItem
