-- chunkname: @modules/logic/seasonver/act123/controller/Season123EquipController.lua

module("modules.logic.seasonver.act123.controller.Season123EquipController", package.seeall)

local Season123EquipController = class("Season123EquipController", BaseController)

function Season123EquipController:onInit()
	return
end

function Season123EquipController:onInitFinish()
	return
end

function Season123EquipController:reInit()
	return
end

Season123EquipController.Toast_Save_Succ = 2855
Season123EquipController.Toast_Empty_Slot = 2856
Season123EquipController.Toast_TrialEquipNoChange = 40601

function Season123EquipController:onOpenView(actId, group, stage, layer, pos, slot)
	self._isOpening = true

	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnModifyHeroGroup, self.handleHeroGroupUpdated, self)
	HeroGroupController.instance:registerCallback(HeroGroupEvent.OnSnapshotSaveSucc, self.handleSnapshotSaveSucc, self)
	Season123Controller.instance:registerCallback(Season123Event.OnEquipItemChange, self.handleItemChanged, self)
	Season123Controller.instance:registerCallback(Season123Event.OnPlayerPrefNewUpdate, self.handlePlayerPrefNewUpdate, self)
	Season123EquipItemListModel.instance:initDatas(actId, group, stage, layer, pos, slot)
end

function Season123EquipController:onCloseView()
	self._isOpening = false

	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnModifyHeroGroup, self.handleHeroGroupUpdated, self)
	HeroGroupController.instance:unregisterCallback(HeroGroupEvent.OnSnapshotSaveSucc, self.handleSnapshotSaveSucc, self)
	Season123Controller.instance:unregisterCallback(Season123Event.OnEquipItemChange, self.handleItemChanged, self)
	Season123Controller.instance:unregisterCallback(Season123Event.OnPlayerPrefNewUpdate, self.handlePlayerPrefNewUpdate, self)
	Season123EquipItemListModel.instance:flushRecord()
	Season123Controller.instance:dispatchEvent(Season123Event.OnPlayerPrefNewUpdate)
	Season123EquipItemListModel.instance:clear()
end

function Season123EquipController:handleHeroGroupUpdated()
	if not self._isOpening then
		return
	end

	Season123EquipItemListModel.instance:initPosData()
	self:notifyUpdateView()
end

function Season123EquipController:handleSnapshotSaveSucc(snapshotId)
	if not self._isOpening then
		return
	end

	if snapshotId == ModuleEnum.HeroGroupSnapshotType.Season123 then
		Season123EquipItemListModel.instance:initPosData()
		self:notifyUpdateView()
	end
end

function Season123EquipController:handleItemChanged()
	if not self._isOpening then
		return
	end

	Season123EquipItemListModel.instance:initItemMap()
	Season123EquipItemListModel.instance:checkResetCurSelected()
	Season123EquipItemListModel.instance:initPlayerPrefs()
	Season123EquipItemListModel.instance:initPosData()
	Season123EquipItemListModel.instance:initList()
	self:notifyUpdateView()
end

function Season123EquipController:equipItemOnlyShow(itemUid)
	local curSlot = Season123EquipItemListModel.instance.curSelectSlot
	local oldUid = Season123EquipItemListModel.instance.curEquipMap[curSlot]
	local unloadSlotIndex

	for slot, equipedUid in pairs(Season123EquipItemListModel.instance.curEquipMap) do
		if curSlot ~= slot and itemUid == equipedUid then
			Season123EquipItemListModel.instance:unloadShowSlot(slot)

			unloadSlotIndex = slot
		end
	end

	Season123EquipItemListModel.instance:equipShowItem(itemUid)
	Season123EquipItemListModel.instance:onModelUpdate()
	self:dispatchEvent(Season123EquipEvent.EquipChangeCard, {
		isNew = oldUid == Activity123Enum.EmptyUid,
		unloadSlot = unloadSlotIndex
	})
end

function Season123EquipController:unloadItem(itemUid)
	Season123EquipItemListModel.instance:unloadItem(itemUid)
	self:notifyUpdateView()
end

function Season123EquipController:setSlot(slotIndex)
	Season123EquipItemListModel.instance:changeSelectSlot(slotIndex)
	Season123EquipItemListModel.instance:onModelUpdate()
	self:dispatchEvent(Season123EquipEvent.EquipChangeSlot)
end

function Season123EquipController:resumeShowSlot()
	Season123EquipItemListModel.instance:resumeSlotData()
	self:notifyUpdateView()
end

function Season123EquipController:checkCanSaveSlot()
	if not Season123EquipItemListModel.instance.activityId then
		return
	end

	if self:checkSlotUnlock() then
		GameFacade.showToast(SeasonEquipItem.Toast_Slot_Lock)

		return
	end

	if Season123EquipItemListModel.instance:isAllSlotEmpty() then
		GameFacade.showToast(Season123EquipController.Toast_Empty_Slot)

		return
	end

	if Season123EquipItemListModel.instance:curSelectIsTrialEquip() or Season123EquipItemListModel.instance:curMapIsTrialEquipMap() then
		GameFacade.showToast(Season123EquipController.Toast_TrialEquipNoChange)

		return
	end

	return true
end

function Season123EquipController:saveShowSlot()
	local equipCount = Season123EquipItemListModel.instance:getEquipMaxCount(Season123EquipItemListModel.instance.curPos)

	for slot = 1, equipCount do
		Season123EquipItemListModel.instance:flushSlot(slot)
	end

	local equipInfos = Season123EquipItemListModel.instance:flushGroup()
	local heroGroupMO = Season123EquipItemListModel.instance:getGroupMO()

	for k, v in pairs(equipInfos) do
		if v.index == Activity123Enum.MainCharPos then
			local equipMO = heroGroupMO.activity104Equips[v.index]

			for i, uid in ipairs(v.equipUid) do
				equipMO.equipUid[i] = uid
			end
		else
			heroGroupMO:updateActivity104PosEquips(v)
		end
	end

	Season123HeroGroupUtils.formation104Equips(heroGroupMO)
	self:syncHeroGroupMO(Season123EquipItemListModel.instance.groupIndex, heroGroupMO)
	self:notifyUpdateView()
end

function Season123EquipController:syncHeroGroupMO(groupIndex, heroGroupMO)
	HeroGroupModel.instance:saveCurGroupData(nil, nil, heroGroupMO)
end

function Season123EquipController:checkSlotUnlock()
	local curPos = Season123EquipItemListModel.instance.curPos

	if curPos ~= Season123EquipItemListModel.MainCharPos then
		return Season123EquipItemListModel.instance:getShowUnlockSlotCount() <= 0
	else
		for slot = Activity123Enum.MainCardNum, 1, -1 do
			if Season123EquipItemListModel.instance:isEquipCardPosUnlock(slot, curPos) then
				return false
			end
		end

		return true
	end
end

function Season123EquipController:checkHeroGroupCardExist(actId)
	local seasonMO = Season123Model.instance:getActInfo(actId)

	if not seasonMO then
		return
	end

	local heroGroupDict = seasonMO.heroGroupSnapshot
	local itemMap = Season123Model.instance:getAllItemMo(actId) or {}

	for groupIndex, heroGroupMO in pairs(heroGroupDict) do
		local isModified = self:checkSingleHeroGroupExist(heroGroupMO, itemMap)

		if isModified then
			logNormal("group [" .. tostring(groupIndex) .. "] need resync!")
			self:syncHeroGroupMO(groupIndex, heroGroupMO)
		end
	end
end

function Season123EquipController:checkSingleHeroGroupExist(heroGroupMO, itemMap, mainEquipId)
	if not heroGroupMO then
		return false
	end

	local isDirty = false

	for pos, equipMO in pairs(heroGroupMO.activity104Equips) do
		local isMainPos = Season123EquipItemListModel.MainCharPos == pos

		for equipIndex, itemUid in pairs(equipMO.equipUid) do
			if itemUid ~= Activity123Enum.EmptyUid and itemMap[itemUid] == nil then
				equipMO.equipUid[equipIndex] = Activity123Enum.EmptyUid
				isDirty = true
			end

			if isMainPos and equipMO.equipUid[equipIndex] == Activity123Enum.EmptyUid then
				equipMO.equipUid[equipIndex] = mainEquipId or Activity123Enum.EmptyUid
			end
		end
	end

	return isDirty
end

function Season123EquipController:exchangeEquip(srcPos, srcSlot, srcEquipUid, tarPos, tarSlot, tarEquipUid, groupIndex)
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

	self:syncHeroGroupMO(groupIndex, curGroupMo)
	self:notifyUpdateView()
end

function Season123EquipController:handlePlayerPrefNewUpdate()
	if Season123EquipItemListModel.instance.recordNew then
		Season123EquipItemListModel.instance.recordNew:initLocalSave()
	end

	self:notifyUpdateView()
end

function Season123EquipController:notifyUpdateView()
	Season123EquipItemListModel.instance:onModelUpdate()
	self:dispatchEvent(Season123EquipEvent.EquipUpdate)
end

function Season123EquipController:setSelectTag(tagIndex)
	if Season123EquipItemListModel.instance.tagModel then
		Season123EquipItemListModel.instance.tagModel:selectTagIndex(tagIndex)
		Season123EquipItemListModel.instance:initList()
	end
end

function Season123EquipController:getFilterModel()
	return Season123EquipItemListModel.instance.tagModel
end

function Season123EquipController:getCurMainEquipId(slot)
	local mainRolePos = ModuleEnum.MaxHeroCountInGroup + 1
	local curGroupMO = HeroGroupModel.instance:getCurGroupMO()

	if curGroupMO then
		local equipMO = curGroupMO.activity104Equips[mainRolePos - 1]

		if equipMO and equipMO.equipUid[slot] then
			return tonumber(equipMO.equipUid[slot])
		end
	end
end

function Season123EquipController:checkHeroGroupCardExistInEpisode(heroGroupMO, actId, stage, layer)
	local episodeCo = Season123Config.instance:getSeasonEpisodeCo(actId, stage, layer)
	local list = string.split(episodeCo.usableEquip, "#")
	local itemMap = {}

	for _, equipId in ipairs(list) do
		itemMap[equipId] = true
	end

	local stageCO = Season123Config.instance:getStageCo(actId, stage)
	local selectCardList = string.split(stageCO.mainEquip, "#")

	for _, equipId in ipairs(selectCardList) do
		itemMap[equipId] = true
	end

	local mainEquipId = tostring(selectCardList[1])
	local isModified = self:checkSingleHeroGroupExist(heroGroupMO, itemMap, mainEquipId)

	if isModified then
		self:syncHeroGroupMO(heroGroupMO)
	end
end

Season123EquipController.instance = Season123EquipController.New()

LuaEventSystem.addEventMechanism(Season123EquipController.instance)

return Season123EquipController
