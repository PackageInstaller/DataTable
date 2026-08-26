-- chunkname: @modules/logic/seasonver/act123/controller/Season123EquipHeroController.lua

module("modules.logic.seasonver.act123.controller.Season123EquipHeroController", package.seeall)

local Season123EquipHeroController = class("Season123EquipHeroController", BaseController)

function Season123EquipHeroController:onInit()
	return
end

function Season123EquipHeroController:onInitFinish()
	return
end

function Season123EquipHeroController:reInit()
	return
end

Season123EquipHeroController.Toast_Save_Succ = 2855

function Season123EquipHeroController:onOpenView(actId, stage, slot, callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj

	Season123Controller.instance:registerCallback(Season123Event.OnEquipItemChange, self.handleItemChanged, self)
	Season123Controller.instance:registerCallback(Season123Event.OnPlayerPrefNewUpdate, self.handlePlayerPrefNewUpdate, self)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, self.handleSnapshotSaveSucc, self)
	self:initModelData(actId, stage, slot)
end

function Season123EquipHeroController:onCloseView()
	self._isOpening = false

	Season123Controller.instance:unregisterCallback(Season123Event.OnEquipItemChange, self.handleItemChanged, self)
	Season123Controller.instance:unregisterCallback(Season123Event.OnPlayerPrefNewUpdate, self.handlePlayerPrefNewUpdate, self)
	Season123Controller.instance:unregisterCallback(Season123Event.OnSnapshotSaveSucc, self.handleSnapshotSaveSucc, self)
	Season123EquipHeroItemListModel.instance:flushRecord()
	Season123Controller.instance:dispatchEvent(Season123Event.OnPlayerPrefNewUpdate)
	Season123EquipHeroItemListModel.instance:clear()
end

function Season123EquipHeroController:initModelData(actId, stage, slot)
	self._isOpening = true

	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local equipUidList

	Season123EquipHeroItemListModel.instance:initDatas(actId, stage, slot, (heroGroupMO and heroGroupMO.activity104Equips and heroGroupMO.activity104Equips[Activity123Enum.MainCharPos] or nil) and tabletool.copy(heroGroupMO.activity104Equips[Activity123Enum.MainCharPos].equipUid))
end

function Season123EquipHeroController:handleSnapshotSaveSucc(snapshotId)
	if not self._isOpening then
		return
	end

	if snapshotId == ModuleEnum.HeroGroupSnapshotType.Season123 then
		if self._callback then
			if self._callbackObj then
				self._callback(self._callbackObj, snapshotId)
			else
				self._callback(snapshotId)
			end
		end

		self:notifyUpdateView()
	end
end

function Season123EquipHeroController:handleItemChanged()
	if not self._isOpening then
		return
	end

	Season123EquipHeroItemListModel.instance:initItemMap()
	Season123EquipHeroItemListModel.instance:checkResetCurSelected()
	Season123EquipHeroItemListModel.instance:initPlayerPrefs()
	Season123EquipHeroItemListModel.instance:initPosData()
	Season123EquipHeroItemListModel.instance:initList()
	self:notifyUpdateView()
end

function Season123EquipHeroController:equipItemOnlyShow(itemUid)
	local curSlot = Season123EquipHeroItemListModel.instance.curSelectSlot
	local oldUid = Season123EquipHeroItemListModel.instance.curEquipMap[curSlot]
	local unloadSlotIndex

	for slot, equipedUid in pairs(Season123EquipHeroItemListModel.instance.curEquipMap) do
		if curSlot ~= slot and itemUid == equipedUid then
			Season123EquipHeroItemListModel.instance:unloadShowSlot(slot)

			unloadSlotIndex = slot
		end
	end

	Season123EquipHeroItemListModel.instance:equipShowItem(itemUid)
	Season123EquipHeroItemListModel.instance:onModelUpdate()
	self:dispatchEvent(Season123EquipEvent.EquipChangeCard, {
		isNew = oldUid == Activity123Enum.EmptyUid,
		unloadSlot = unloadSlotIndex
	})
end

function Season123EquipHeroController:unloadItem(itemUid)
	Season123EquipHeroItemListModel.instance:unloadItem(itemUid)
	self:notifyUpdateView()
end

function Season123EquipHeroController:setSlot(slotIndex)
	Season123EquipHeroItemListModel.instance:changeSelectSlot(slotIndex)
	Season123EquipHeroItemListModel.instance:onModelUpdate()
	self:dispatchEvent(Season123EquipEvent.EquipChangeSlot)
end

function Season123EquipHeroController:resumeShowSlot()
	Season123EquipHeroItemListModel.instance:resumeSlotData()
	self:notifyUpdateView()
end

function Season123EquipHeroController:checkCanSaveSlot()
	if not Season123EquipHeroItemListModel.instance.activityId then
		return
	end

	if self:checkSlotUnlock() then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return
	end

	return true
end

function Season123EquipHeroController:saveShowSlot()
	local equipCount = Season123EquipHeroItemListModel.instance:getEquipMaxCount(Season123EquipHeroItemListModel.instance.curPos)

	for slot = 1, equipCount do
		Season123EquipHeroItemListModel.instance:flushSlot(slot)
	end

	local equipUidList = Season123EquipHeroItemListModel.instance:getEquipedCards()
	local heroGroupMO = HeroGroupModel.instance:getCurGroupMO()
	local activity104Equips = heroGroupMO and heroGroupMO:getAct104PosEquips(Activity123Enum.MainCharPos)

	if activity104Equips then
		for slot, equipUid in ipairs(equipUidList) do
			if not equipUidList[slot] then
				activity104Equips.equipUid[slot] = equipUidList[slot]
			end
		end

		HeroGroupModel.instance:saveCurGroupData()
	end
end

function Season123EquipHeroController:checkSlotUnlock()
	local curPos = Season123EquipHeroItemListModel.instance.curPos

	if curPos ~= Season123EquipHeroItemListModel.MainCharPos then
		return Season123EquipHeroItemListModel.instance:getShowUnlockSlotCount() <= 0
	else
		for slot = Activity123Enum.MainCardNum, 1, -1 do
			if Season123Model.instance:isSeasonStagePosUnlock(Season123EquipHeroItemListModel.instance.activityId, Season123EquipHeroItemListModel.instance.stage, slot, curPos) then
				return false
			end
		end

		return true
	end
end

function Season123EquipHeroController:handlePlayerPrefNewUpdate()
	if Season123EquipHeroItemListModel.instance.recordNew then
		Season123EquipHeroItemListModel.instance.recordNew:initLocalSave()
	end

	self:notifyUpdateView()
end

function Season123EquipHeroController:notifyUpdateView()
	Season123EquipHeroItemListModel.instance:onModelUpdate()
	self:dispatchEvent(Season123EquipEvent.EquipUpdate)
end

function Season123EquipHeroController:setSelectTag(tagIndex)
	if Season123EquipHeroItemListModel.instance.tagModel then
		Season123EquipHeroItemListModel.instance.tagModel:selectTagIndex(tagIndex)
		Season123EquipHeroItemListModel.instance:initList()
	end
end

function Season123EquipHeroController:getFilterModel()
	return Season123EquipHeroItemListModel.instance.tagModel
end

function Season123EquipHeroController:realEquipItem(actId, stage, slot, equipUid)
	if not self._isOpening then
		self:initModelData(actId, stage, slot)
	end

	self:equipItemOnlyShow(equipUid)

	if self:checkCanSaveSlot() then
		self:saveShowSlot()
	end
end

Season123EquipHeroController.instance = Season123EquipHeroController.New()

LuaEventSystem.addEventMechanism(Season123EquipHeroController.instance)

return Season123EquipHeroController
