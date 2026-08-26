-- chunkname: @modules/logic/seasonver/act123/model/Season123EquipHeroItemListModel.lua

module("modules.logic.seasonver.act123.model.Season123EquipHeroItemListModel", package.seeall)

local Season123EquipHeroItemListModel = class("Season123EquipHeroItemListModel", ListScrollModel)

Season123EquipHeroItemListModel.MainCharPos = ModuleEnum.MaxHeroCountInGroup
Season123EquipHeroItemListModel.TotalEquipPos = 5

function Season123EquipHeroItemListModel:clear()
	Season123EquipHeroItemListModel.super.clear(self)

	self.activityId = nil
	self.curPos = nil
	self.equipUid2Pos = nil
	self.equipUid2Group = nil
	self.equipUid2Slot = nil
	self.curEquipMap = nil
	self.curSelectSlot = nil
	self._itemMap = nil
	self.recordNew = nil
	self._itemStartAnimTime = nil
	self._deckUidMap = nil
	self._itemIdDeckCountMap = nil
	self.tagModel = nil
end

function Season123EquipHeroItemListModel:initDatas(activityId, stage, slotIndex, equipUidList)
	logNormal("Season123EquipHeroItemListModel initDatas")
	self:clear()

	self.activityId = activityId
	self.stage = stage
	self.curPos = Season123EquipHeroItemListModel.MainCharPos
	self.equipUid2Pos = {}
	self.equipUid2Slot = {}

	local posMaxCount = self:getEquipMaxCount(self.curPos)

	self.curEquipMap = {}

	for i = 1, posMaxCount do
		self.curEquipMap[i] = Activity123Enum.EmptyUid
	end

	self.curSelectSlot = slotIndex or 1
	self.equipUid2Group = {}

	self:initSubModel()
	self:initUnlockIndex()
	self:initItemMap()
	self:initPlayerPrefs()
	self:initPosData(equipUidList)
	self:initList()
end

function Season123EquipHeroItemListModel:initSubModel()
	self.tagModel = Season123EquipTagModel.New()

	self.tagModel:init(self.activityId)
end

function Season123EquipHeroItemListModel:initUnlockIndex()
	self.curUnlockIndexSet = Season123HeroGroupUtils.getUnlockSlotSet(self.activityId)
end

function Season123EquipHeroItemListModel:initItemMap()
	self._itemMap = {}

	local stageConfig = Season123Config.instance:getStageCo(self.activityId, self.stage)
	local list = string.splitToNumber(stageConfig.mainEquip, "#")

	for _, itemId in ipairs(list) do
		local itemMO = Season123ItemMO.New()
		local uid = tostring(itemId)

		itemMO:setData({
			quantity = 1,
			itemId = itemId,
			uid = uid
		})

		self._itemMap[uid] = itemMO
	end
end

function Season123EquipHeroItemListModel:initPlayerPrefs()
	self.recordNew = Season123EquipLocalRecord.New()

	self.recordNew:init(self.activityId, Activity123Enum.PlayerPrefsKeyItemUid)
end

function Season123EquipHeroItemListModel:initPosData(equipUidList)
	if not equipUidList then
		return
	end

	for slot, equipUid in pairs(equipUidList) do
		self:setCardPosData(equipUid, self.curPos, slot)
	end
end

function Season123EquipHeroItemListModel:setCardPosData(equipUid, pos, slot)
	self.equipUid2Pos[equipUid] = pos
	self.equipUid2Slot[equipUid] = slot

	if pos == self.curPos then
		self.curEquipMap[slot] = equipUid
	end
end

function Season123EquipHeroItemListModel:initList()
	local list = {}

	for itemUid, itemMO in pairs(self._itemMap) do
		self:setListData(itemMO.itemId, itemUid, itemMO, list)
	end

	local battleCO = HeroGroupModel.instance.battleConfig

	if battleCO and battleCO.trialMainAct104EuqipId > 0 then
		local slot = 1
		local equipUid = Season123EquipHeroItemListModel.getTrialEquipUID(battleCO.trialMainAct104EuqipId, slot)

		self:setListData(battleCO.trialMainAct104EuqipId, equipUid, nil, list)
	end

	table.sort(list, Season123EquipHeroItemListModel.sortItemMOList)

	self._originList = list

	self:refreshMergeList()
end

function Season123EquipHeroItemListModel:setListData(itemId, itemUid, itemMO, list)
	if not SeasonConfig.instance:getEquipIsOptional(itemId) then
		local itemCO = Season123Config.instance:getSeasonEquipCo(itemId)

		if itemCO and self:isCardFitRole(itemCO) and self:isCardCanShowByTag(itemUid, itemCO.tag) and itemCO.isCardBag ~= "1" then
			self.equipUid2Group[itemUid] = itemCO.group

			if not itemMO then
				itemMO = Season123ItemMO.New()

				itemMO:setData({
					quantity = 1,
					itemId = itemId,
					uid = itemUid
				})
			end

			local mo = Season123EquipListMo.New()

			mo:init(itemMO)
			table.insert(list, mo)
		end
	end
end

function Season123EquipHeroItemListModel:isCardFitRole(itemCO)
	if self.curPos == Season123EquipHeroItemListModel.MainCharPos then
		return Season123EquipMetaUtils.isMainRoleCard(itemCO)
	else
		return not Season123EquipMetaUtils.isMainRoleCard(itemCO)
	end
end

function Season123EquipHeroItemListModel:isCardCanShowByTag(itemUid, itemTags)
	if self.tagModel then
		return self.tagModel:isCardNeedShow(itemTags)
	end

	return true
end

function Season123EquipHeroItemListModel:refreshMergeList()
	local list = {}
	local curSelectIdMap = {}
	local itemIdCountMap = {}
	local deckIdMap = {}

	for k, v in pairs(self.curEquipMap) do
		if v ~= Activity123Enum.EmptyUid then
			curSelectIdMap[v] = true
		end
	end

	for i = 1, #self._originList do
		local itemUid = self._originList[i].id
		local itemId = self._originList[i].itemId

		if curSelectIdMap[itemUid] or self.equipUid2Pos[itemUid] then
			table.insert(list, self._originList[i])
		else
			local curCount = itemIdCountMap[itemId]

			if curCount == nil then
				table.insert(list, self._originList[i])

				itemIdCountMap[itemId] = 1
				deckIdMap[itemUid] = itemId
			else
				itemIdCountMap[itemId] = curCount + 1
			end
		end
	end

	self._deckUidMap = deckIdMap
	self._itemIdDeckCountMap = itemIdCountMap

	self:setList(list)
end

function Season123EquipHeroItemListModel:changeSelectSlot(slotIndex)
	local posMaxCount = self:getEquipMaxCount(self.curPos)

	if slotIndex <= posMaxCount and slotIndex > 0 then
		self.curSelectSlot = slotIndex
	end
end

function Season123EquipHeroItemListModel:getEquipMO(itemUid)
	return self._itemMap[itemUid]
end

function Season123EquipHeroItemListModel:equipShowItem(itemUid)
	self.curEquipMap[self.curSelectSlot] = itemUid
end

function Season123EquipHeroItemListModel:equipItem(itemUid, slot)
	self.curEquipMap[slot] = itemUid
	self.equipUid2Pos[itemUid] = self.curPos
	self.equipUid2Slot[itemUid] = slot
end

function Season123EquipHeroItemListModel:unloadShowSlot(slot)
	self.curEquipMap[slot] = Activity123Enum.EmptyUid
end

function Season123EquipHeroItemListModel:unloadItem(itemUid)
	self.equipUid2Pos[itemUid] = nil
	self.equipUid2Slot[itemUid] = nil

	local posMaxCount = self:getEquipMaxCount(self.curPos)

	for i = 1, posMaxCount do
		if self.curEquipMap[i] == itemUid then
			self.curEquipMap[i] = Activity123Enum.EmptyUid
		end
	end
end

function Season123EquipHeroItemListModel:unloadItemByPos(targetPos, targetSlot)
	for itemUid, oldPos in pairs(self.equipUid2Pos) do
		if oldPos == targetPos then
			local slot = self.equipUid2Slot[itemUid]

			if slot == targetSlot then
				self:unloadItem(itemUid)

				return
			end
		end
	end
end

function Season123EquipHeroItemListModel:getItemUidByPos(targetPos, targetSlot)
	for itemUid, oldPos in pairs(self.equipUid2Pos) do
		if oldPos == targetPos then
			local slot = self.equipUid2Slot[itemUid]

			if slot == targetSlot then
				return itemUid
			end
		end
	end

	return Activity123Enum.EmptyUid
end

function Season123EquipHeroItemListModel:getItemEquipedPos(itemUid)
	return self.equipUid2Pos[itemUid], self.equipUid2Slot[itemUid]
end

function Season123EquipHeroItemListModel:getEquipMaxCount(pos)
	return (pos == Season123EquipHeroItemListModel.MainCharPos or nil) and (Activity123Enum.MainCardNum or Activity123Enum.HeroCardNum)
end

function Season123EquipHeroItemListModel:getPosHeroUid(targetPos)
	return nil
end

function Season123EquipHeroItemListModel:slotIsLock(slotIndex)
	return not Season123Model.instance:isSeasonStagePosUnlock(self.activityId, self.stage, slotIndex, self.curPos)
end

function Season123EquipHeroItemListModel:disableBecauseSameCard(itemUid)
	local groupId = self.equipUid2Group[itemUid]

	if groupId then
		for slot, equipedUid in pairs(self.curEquipMap) do
			local equipedGroup = self.equipUid2Group[equipedUid]

			if equipedGroup and slot ~= self.curSelectSlot and equipedGroup == groupId then
				return true
			end
		end
	end

	return false
end

function Season123EquipHeroItemListModel:disableBecauseRole(itemId)
	local itemCo = SeasonConfig.instance:getSeasonEquipCo(itemId)

	if not itemCo then
		return false
	end

	local isMainRoleCard = Season123EquipMetaUtils.isMainRoleCard(itemCo)

	if self.curPos == Season123EquipHeroItemListModel.MainCharPos then
		if isMainRoleCard then
			return false
		end
	elseif not isMainRoleCard then
		return false
	end

	return true
end

function Season123EquipHeroItemListModel:isItemUidInShowSlot(itemUid)
	return self.curEquipMap[self.curSelectSlot] == itemUid
end

function Season123EquipHeroItemListModel:isAllSlotEmpty()
	local equipCount = self:getEquipMaxCount(self.curPos)

	for slot = 1, equipCount do
		if self.curEquipMap[slot] ~= Activity123Enum.EmptyUid then
			return false
		end
	end

	return true
end

function Season123EquipHeroItemListModel.sortItemMOList(a, b)
	local cfgA = Season123Config.instance:getSeasonEquipCo(a.itemId)
	local cfgB = Season123Config.instance:getSeasonEquipCo(b.itemId)

	if cfgA ~= nil and cfgB ~= nil then
		local rareFitA = Season123EquipHeroItemListModel.instance:disableBecauseRole(a.itemId)
		local rareFitB = Season123EquipHeroItemListModel.instance:disableBecauseRole(b.itemId)

		if rareFitB ~= rareFitA then
			return rareFitB
		end

		if cfgA.rare ~= cfgB.rare then
			return cfgA.rare > cfgB.rare
		else
			return cfgA.equipId > cfgB.equipId
		end
	else
		return a.id < b.id
	end
end

function Season123EquipHeroItemListModel:flushSlot(slot)
	local itemUid = self.curEquipMap[slot]

	self:unloadItemByPos(self.curPos, slot)

	if itemUid ~= Activity123Enum.EmptyUid then
		self:unloadTeamLimitCard(itemUid)
		self:unloadItem(itemUid)
		self:equipItem(itemUid, slot)
	end
end

function Season123EquipHeroItemListModel:unloadTeamLimitCard(targetItemUid)
	local targetItemMO = self:getById(targetItemUid)

	if not targetItemMO then
		return
	end

	local list = self:getList()
	local targetItemCO = Season123Config.instance:getSeasonEquipCo(targetItemMO.itemId)
	local isDirty = false

	if targetItemCO and targetItemCO.teamLimit == 0 then
		return false
	end

	for uid, _ in pairs(self.equipUid2Pos) do
		if uid ~= targetItemUid and self._itemMap[uid] then
			local tmpItemCO = Season123Config.instance:getSeasonEquipCo(self._itemMap[uid].itemId)

			if tmpItemCO and tmpItemCO.teamLimit ~= 0 and tmpItemCO.teamLimit == targetItemCO.teamLimit then
				self:unloadItem(uid)

				isDirty = true
			end
		end
	end

	return isDirty
end

function Season123EquipHeroItemListModel:resumeSlotData()
	local slotMaxCount = self:getEquipMaxCount(self.curPos)

	for slotIndex = 1, slotMaxCount do
		self.curEquipMap[slotIndex] = self:getItemUidByPos(self.curPos, slotIndex)
	end
end

function Season123EquipHeroItemListModel:getEquipedCards()
	return (self:packUpdateEquips())
end

function Season123EquipHeroItemListModel:packUpdateEquips()
	local equipInfos = {}

	for slot = 1, Activity123Enum.MainCardNum do
		equipInfos[slot] = self.curEquipMap[slot] or Activity123Enum.EmptyUid
	end

	return equipInfos
end

function Season123EquipHeroItemListModel:checkResetCurSelected()
	local posMaxCount = self:getEquipMaxCount(self.curPos)

	for i = 1, posMaxCount do
		if self.curEquipMap[i] ~= Activity123Enum.EmptyUid and not self._itemMap[self.curEquipMap[i]] then
			self.curEquipMap[i] = Activity123Enum.EmptyUid
		end
	end
end

function Season123EquipHeroItemListModel:getShowUnlockSlotCount()
	local slotCount = 0
	local pos = self.curPos
	local maxSlot = self:getEquipMaxCount(pos)

	for slot = maxSlot, 1, -1 do
		if self:isEquipCardPosUnlock(slot, pos) then
			slotCount = math.max(slotCount, slot)

			return slotCount
		end
	end

	return slotCount
end

function Season123EquipHeroItemListModel:isEquipCardPosUnlock(slot, pos)
	local posIndex = Season123Model.instance:getUnlockCardIndex(pos, slot)

	return self.curUnlockIndexSet[posIndex] == true
end

function Season123EquipHeroItemListModel:getNeedShowDeckCount(itemUid)
	local itemId = self._deckUidMap[itemUid]

	if itemId == nil then
		return false
	end

	local count = self._itemIdDeckCountMap[itemId]

	return count > 1, count
end

function Season123EquipHeroItemListModel:getDelayPlayTime(mo)
	if mo == nil then
		return -1
	end

	if self.curPos == Season123EquipHeroItemListModel.MainCharPos then
		if not SeasonEquipHeroViewContainer.ColumnCount then
			local columnCount = SeasonEquipItem.ColumnCount
			local curTime = Time.time

			if self._itemStartAnimTime == nil then
				self._itemStartAnimTime = curTime + SeasonEquipItem.OpenAnimStartTime
			end

			local index = self:getIndex(mo)

			if not index or index > SeasonEquipItem.AnimRowCount * columnCount then
				return -1
			end

			local delayTime = math.floor((index - 1) / columnCount) * SeasonEquipItem.OpenAnimTime + SeasonEquipItem.OpenAnimStartTime
			local passTime = curTime - self._itemStartAnimTime

			if delayTime < passTime then
				return -1
			else
				return delayTime - passTime
			end
		end
	end
end

function Season123EquipHeroItemListModel:flushRecord()
	if self.recordNew then
		self.recordNew:recordAllItem()
	end
end

Season123EquipHeroItemListModel.instance = Season123EquipHeroItemListModel.New()

return Season123EquipHeroItemListModel
