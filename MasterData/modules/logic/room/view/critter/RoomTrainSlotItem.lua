-- chunkname: @modules/logic/room/view/critter/RoomTrainSlotItem.lua

module("modules.logic.room.view.critter.RoomTrainSlotItem", package.seeall)

local RoomTrainSlotItem = class("RoomTrainSlotItem", ListScrollCellExtend)

function RoomTrainSlotItem:onInitView()
	self._goadd = gohelper.findChild(self.viewGO, "#go_add")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._gocrittenIcon = gohelper.findChild(self.viewGO, "#go_unlock/#go_crittenIcon")
	self._simageheroIcon = gohelper.findChildSingleImage(self.viewGO, "#go_unlock/#simage_heroIcon")
	self._simagetotalBarValue = gohelper.findChildSingleImage(self.viewGO, "#go_unlock/ProgressBg/#simage_totalBarValue")
	self._goselect = gohelper.findChild(self.viewGO, "#go_unlock/#go_select")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_unlock/#go_finish")
	self._gobubble = gohelper.findChild(self.viewGO, "#go_unlock/#go_bubble")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomTrainSlotItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickitemOnClick, self)
end

function RoomTrainSlotItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function RoomTrainSlotItem:_btnclickitemOnClick()
	if self._view and self._view.viewContainer then
		if not self._slotMO or self._slotMO.isLock then
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)

			return
		end

		self._view.viewContainer:dispatchEvent(CritterEvent.UITrainSelectSlot, self:getDataMO())
	end
end

function RoomTrainSlotItem:_editableInitView()
	self._imageTrainBarValue = gohelper.findChildImage(self.viewGO, "#go_unlock/ProgressBg/#simage_totalBarValue")
end

function RoomTrainSlotItem:_editableAddEvents()
	if self._view and self._view.viewContainer then
		self._view.viewContainer:registerCallback(CritterEvent.UITrainCdTime, self._opTranCdTimeUpdate, self)
	end
end

function RoomTrainSlotItem:_editableRemoveEvents()
	if self._view and self._view.viewContainer then
		self._view.viewContainer:unregisterCallback(CritterEvent.UITrainCdTime, self._opTranCdTimeUpdate, self)
	end
end

function RoomTrainSlotItem:getDataMO()
	return self._slotMO
end

function RoomTrainSlotItem:onUpdateMO(mo)
	self._slotMO = mo

	self:refreshUI()
end

function RoomTrainSlotItem:_opTranCdTimeUpdate()
	self:_refreshTrainProgressUI()
end

function RoomTrainSlotItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function RoomTrainSlotItem:onDestroyView()
	return
end

function RoomTrainSlotItem:refreshUI()
	local isLock = self._slotMO.isLock
	local isHasCritter = self._slotMO.critterMO ~= nil

	gohelper.setActive(self._golock, isLock)
	gohelper.setActive(self._goadd, not isHasCritter)
	gohelper.setActive(self._gounlock, not isLock and isHasCritter)

	if not isLock and isHasCritter then
		self:_refreshCritterUI()
		self:_refreshTrainProgressUI()
	end

	local redDot = not isLock and self._slotMO.id == 1

	gohelper.setActive(self._goreddot, redDot)

	if redDot then
		RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.RoomCritterTrainOcne)
	end
end

function RoomTrainSlotItem:_refreshCritterUI()
	local critterMO = self._slotMO.critterMO

	if critterMO then
		self.critterIcon = self.critterIcon or IconMgr.instance:getCommonCritterIcon(self._gocrittenIcon)

		self.critterIcon:setMOValue(critterMO:getId(), critterMO:getDefineId())

		local heroMO = HeroModel.instance:getByHeroId(critterMO.trainInfo.heroId)

		if heroMO then
			::label_14_0::

			local skinConfig = SkinConfig.instance:getSkinCo(heroMO.skin)

			if skinConfig then
				self._simageheroIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
			end
		end
	end
end

function RoomTrainSlotItem:_refreshTrainProgressUI()
	if self._slotMO then
		local critterMO = self._slotMO.critterMO

		if critterMO and critterMO.trainInfo then
			local trainInfo = critterMO.trainInfo

			gohelper.setActive(self._gofinish, critterMO.trainInfo:isTrainFinish())
			gohelper.setActive(self._gobubble, critterMO.trainInfo:isHasEventTrigger())

			local process = trainInfo:getProcess()
			local min = 0.05
			local max = 0.638

			self._imageTrainBarValue.fillAmount = min + process * (max - min)
		end
	end
end

RoomTrainSlotItem.prefabPath = "ui/viewres/room/critter/roomtrainslotitem.prefab"

return RoomTrainSlotItem
