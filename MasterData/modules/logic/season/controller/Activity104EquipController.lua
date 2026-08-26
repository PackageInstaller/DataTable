-- chunkname: @modules/logic/season/controller/Activity104EquipController.lua

module("modules.logic.season.controller.Activity104EquipController", package.seeall)

local Activity104EquipController = class("Activity104EquipController", BaseController)

function Activity104EquipController:onInit()
	return
end

function Activity104EquipController:onInitFinish()
	return
end

function Activity104EquipController:reInit()
	return
end

Activity104EquipController.Toast_Save_Succ = 2855
Activity104EquipController.Toast_Empty_Slot = 2856
Activity104EquipController.Toast_TrialEquipNoChange = 40601

function Activity104EquipController:onOpenView(actId, group, pos, slot)
	self._isOpening = true

	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, self.handleHeroGroupUpdated, self)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, self.handleSnapshotSaveSucc, self)
	Activity104Controller.instance:registerCallback(Activity104Event.GetAct104ItemChange, self.handleItemChanged, self)
	Activity104Controller.instance:registerCallback(Activity104Event.OnPlayerPrefNewUpdate, self.handlePlayerPrefNewUpdate, self)
	Activity104EquipItemListModel.instance:initDatas(actId, group, pos, slot)
end

function Activity104EquipController:onCloseView()
	self._isOpening = false

	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, self.handleHeroGroupUpdated, self)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, self.handleSnapshotSaveSucc, self)
	Activity104Controller.instance:unregisterCallback(Activity104Event.GetAct104ItemChange, self.handleItemChanged, self)
	Activity104Controller.instance:unregisterCallback(Activity104Event.OnPlayerPrefNewUpdate, self.handlePlayerPrefNewUpdate, self)
	Activity104EquipItemListModel.instance:flushRecord()
	Activity104Controller.instance:dispatchEvent(Activity104Event.OnPlayerPrefNewUpdate)
	Activity104EquipItemListModel.instance:clear()
end

function Activity104EquipController:handleHeroGroupUpdated()
	if not self._isOpening then
		return
	end

	Activity104EquipItemListModel.instance:initPosData()
	self:notifyUpdateView()
end

function Activity104EquipController:handleSnapshotSaveSucc(snapshotId)
	if not self._isOpening then
		return
	end

	if snapshotId == ModuleEnum.HeroGroupType.Season then
		Activity104EquipItemListModel.instance:initPosData()
		self:notifyUpdateView()
	end
end

function Activity104EquipController:handleItemChanged()
	if not self._isOpening then
		return
	end

	Activity104EquipItemListModel.instance:initItemMap()
	Activity104EquipItemListModel.instance:checkResetCurSelected()
	Activity104EquipItemListModel.instance:initPlayerPrefs()
	Activity104EquipItemListModel.instance:initPosData()
	Activity104EquipItemListModel.instance:initList()
	self:notifyUpdateView()
end

function Activity104EquipController:equipItemOnlyShow(itemUid)
	local curSlot = Activity104EquipItemListModel.instance.curSelectSlot
	local oldUid = Activity104EquipItemListModel.instance.curEquipMap[curSlot]
	local unloadSlotIndex

	for slot, equipedUid in pairs(Activity104EquipItemListModel.instance.curEquipMap) do
		if curSlot ~= slot and itemUid == equipedUid then
			Activity104EquipItemListModel.instance:unloadShowSlot(slot)

			unloadSlotIndex = slot
		end
	end

	Activity104EquipItemListModel.instance:equipShowItem(itemUid)
	Activity104EquipItemListModel.instance:onModelUpdate()
	self:dispatchEvent(Activity104EquipEvent.EquipChangeCard, {
		isNew = oldUid == Activity104EquipItemListModel.EmptyUid,
		unloadSlot = unloadSlotIndex
	})
end

function Activity104EquipController:unloadItem(itemUid)
	Activity104EquipItemListModel.instance:unloadItem(itemUid)
	self:notifyUpdateView()
end

function Activity104EquipController:setSlot(slotIndex)
	Activity104EquipItemListModel.instance:changeSelectSlot(slotIndex)
	Activity104EquipItemListModel.instance:onModelUpdate()
	self:dispatchEvent(Activity104EquipEvent.EquipChangeSlot)
end

function Activity104EquipController:resumeShowSlot()
	Activity104EquipItemListModel.instance:resumeSlotData()
	self:notifyUpdateView()
end

function Activity104EquipController:checkCanSaveSlot()
	if not Activity104EquipItemListModel.instance.activityId then
		return
	end

	if self:checkSlotUnlock() then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return
	end

	if Activity104EquipItemListModel.instance:isAllSlotEmpty() then
		GameFacade.showToast(Activity104EquipController.Toast_Empty_Slot)

		return
	end

	if Activity104EquipItemListModel.instance:curSelectIsTrialEquip() or Activity104EquipItemListModel.instance:curMapIsTrialEquipMap() then
		GameFacade.showToast(Activity104EquipController.Toast_TrialEquipNoChange)

		return
	end

	return true
end

function Activity104EquipController:saveShowSlot()
	local equipCount = Activity104EquipItemListModel.instance:getEquipMaxCount(Activity104EquipItemListModel.instance.curPos)

	for slot = 1, equipCount do
		Activity104EquipItemListModel.instance:flushSlot(slot)
	end

	local equipInfos = Activity104EquipItemListModel.instance:flushGroup()
	local heroGroupMO = Activity104EquipItemListModel.instance:getGroupMO()

	for k, v in pairs(equipInfos) do
		heroGroupMO:updateActivity104PosEquips(v)
	end

	self:syncHeroGroupMO(Activity104EquipItemListModel.instance.groupIndex, heroGroupMO)
	self:notifyUpdateView()
end

function Activity104EquipController:syncHeroGroupMO(groupIndex, heroGroupMO)
	HeroGroupModel.instance:saveCurGroupData()
end

function Activity104EquipController:checkSlotUnlock()
	local curPos = Activity104EquipItemListModel.instance.curPos

	if curPos ~= Activity104EquipItemListModel.MainCharPos then
		return Activity104EquipItemListModel.instance:getShowUnlockSlotCount() <= 0
	else
		for slot = Activity104EquipItemListModel.HeroMaxPos, 1, -1 do
			if Activity104Model.instance:isSeasonPosUnlock(Activity104EquipItemListModel.instance.activityId, Activity104EquipItemListModel.instance.groupIndex, slot, curPos) then
				return false
			end
		end

		return true
	end
end

function Activity104EquipController:checkHeroGroupCardExist(actId)
	local heroGroupDict = Activity104Model.instance:getAllHeroGroupSnapshot(actId)
	local itemMap = Activity104Model.instance:getAllItemMo(actId) or {}

	for groupIndex, heroGroupMO in pairs(heroGroupDict) do
		local isModified = self:checkSingleHeroGroupExist(heroGroupMO, groupIndex, itemMap, actId)

		if isModified then
			logNormal("group [" .. tostring(groupIndex) .. "] need resync!")
			self:syncHeroGroupMO(groupIndex, heroGroupMO)
		end
	end
end

function Activity104EquipController:checkSingleHeroGroupExist(heroGroupMO, groupIndex, itemMap, actId)
	if not heroGroupMO then
		return false
	end

	local isDirty = false

	for pos, equipMO in pairs(heroGroupMO.activity104Equips) do
		for equipIndex, itemUid in pairs(equipMO.equipUid) do
			if itemUid ~= Activity104EquipItemListModel.EmptyUid and itemMap[itemUid] == nil then
				logNormal(string.format("empty card [%s] found in group [%s] pos [%s]", itemUid, tostring(groupIndex), tostring(pos)))

				equipMO.equipUid[equipIndex] = Activity104EquipItemListModel.EmptyUid
				isDirty = true
			end
		end
	end

	return isDirty
end

function Activity104EquipController:exchangeEquip(srcPos, srcSlot, srcEquipUid, tarPos, tarSlot, tarEquipUid, groupIndex)
	local curGroupMo = HeroGroupModel.instance:getCurGroupMO()

	if not curGroupMo then
		return
	end

	local equipInfos = curGroupMo.activity104Equips

	for pos, equipGroupMO in pairs(equipInfos) do
		if equipGroupMO.index == srcPos then
			equipGroupMO.equipUid[srcSlot] = tarEquipUid or 0
		end

		if equipGroupMO.index == tarPos then
			equipGroupMO.equipUid[tarSlot] = srcEquipUid or 0
		end
	end

	for k, v in pairs(equipInfos) do
		curGroupMo:updateActivity104PosEquips(v)
	end

	self:syncHeroGroupMO(groupIndex, curGroupMo)
	self:notifyUpdateView()
end

function Activity104EquipController:handlePlayerPrefNewUpdate()
	if Activity104EquipItemListModel.instance.recordNew then
		Activity104EquipItemListModel.instance.recordNew:initLocalSave()
	end

	self:notifyUpdateView()
end

function Activity104EquipController:notifyUpdateView()
	Activity104EquipItemListModel.instance:onModelUpdate()
	self:dispatchEvent(Activity104EquipEvent.EquipUpdate)
end

function Activity104EquipController:setSelectTag(tagIndex)
	if Activity104EquipItemListModel.instance.tagModel then
		Activity104EquipItemListModel.instance.tagModel:selectTagIndex(tagIndex)
		Activity104EquipItemListModel.instance:initList()
	end
end

function Activity104EquipController:getFilterModel()
	return Activity104EquipItemListModel.instance.tagModel
end

Activity104EquipController.instance = Activity104EquipController.New()

LuaEventSystem.addEventMechanism(Activity104EquipController.instance)

return Activity104EquipController
