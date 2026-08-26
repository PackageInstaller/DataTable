-- chunkname: @modules/logic/seasonver/act123/model/Season123EquipItemListModel.lua

module("modules.logic.seasonver.act123.model.Season123EquipItemListModel", package.seeall)

local Season123EquipItemListModel = class("Season123EquipItemListModel", ListScrollModel)

Season123EquipItemListModel.MainCharPos = 4
Season123EquipItemListModel.TotalEquipPos = 5
Season123EquipItemListModel.ColumnCount = 6
Season123EquipItemListModel.AnimRowCount = 4
Season123EquipItemListModel.OpenAnimTime = 0.06
Season123EquipItemListModel.OpenAnimStartTime = 0.05

function Season123EquipItemListModel:clear()
	Season123EquipItemListModel.super.clear(self)

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
	self.curUnlockIndexSet = nil
end

function Season123EquipItemListModel:initDatas(activityId, groupIndex, stage, layer, posIndex, slotIndex)
	logNormal("Season123EquipItemListModel initDatas")
	self:clear()

	self.activityId = activityId
	self.curPos = posIndex
	self.groupIndex = groupIndex
	self.stage = stage
	self.layer = layer
	self.equipUid2Pos = {}
	self.equipUid2Slot = {}

	local posMaxCount = self:getEquipMaxCount(self.curPos)

	self.curEquipMap = {}

	for i = 1, posMaxCount do
		self.curEquipMap[i] = Activity123Enum.EmptyUid
	end

	self.curSelectSlot = slotIndex or 1
	self.equipUid2Group = {}

	self:initUnlockIndex()
	self:initSubModel()
	self:initItemMap()
	self:initPlayerPrefs()
	self:initPosData()
	self:initList()
end

function Season123EquipItemListModel:initUnlockIndex()
	self.curUnlockIndexSet = Season123HeroGroupUtils.getUnlockSlotSet(self.activityId)
end

function Season123EquipItemListModel:initSubModel()
	self.tagModel = Season123EquipTagModel.New()

	self.tagModel:init(self.activityId)
end

function Season123EquipItemListModel:initItemMap()
	local episodeCo = Season123Config.instance:getSeasonEpisodeCo(self.activityId, self.stage, self.layer)
	local list = string.splitToNumber(episodeCo.usableEquip, "#")

	self._itemMap = {}

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

function Season123EquipItemListModel:initPlayerPrefs()
	self.recordNew = Season123EquipLocalRecord.New()

	self.recordNew:init(self.activityId, Activity123Enum.PlayerPrefsKeyItemUid)
end

function Season123EquipItemListModel:initPosData()
	local groupMO = self:getGroupMO()

	if not groupMO then
		return
	end

	local equipInfos = groupMO.activity104Equips

	for pos, equipGroupMO in pairs(equipInfos) do
		local posMaxCount = self:getEquipMaxCount(pos)

		for i = 1, posMaxCount do
			local equipUid = equipGroupMO.equipUid[i]

			self:setCardPosData(equipUid, pos, i)
		end
	end
end

function Season123EquipItemListModel:setCardPosData(equipUid, pos, slot)
	self.equipUid2Pos[equipUid] = pos
	self.equipUid2Slot[equipUid] = slot

	if pos == self.curPos then
		self.curEquipMap[slot] = equipUid
	end
end

function Season123EquipItemListModel:initList()
	local list = {}

	for itemUid, itemMO in pairs(self._itemMap) do
		self:setListData(itemMO.itemId, itemUid, itemMO, list)
	end

	table.sort(list, Season123EquipItemListModel.sortItemMOList)

	self._originList = list

	self:refreshMergeList()
end

function Season123EquipItemListModel:setListData(itemId, itemUid, itemMO, list)
	if not Season123Config.instance:getEquipIsOptional(itemId) then
		local itemCO = Season123Config.instance:getSeasonEquipCo(itemId)

		if itemCO and self:isCardFitRole(itemCO) and self:isCardCanShowByTag(itemUid, itemCO.tag) then
			self.equipUid2Group[itemUid] = itemCO.group

			if not itemMO then
				itemMO = Season123ItemMO.New()

				itemMO:init({
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

function Season123EquipItemListModel.getTrialEquipUID(...)
	local t = {
		...
	}

	return table.concat(t, "#")
end

function Season123EquipItemListModel.isTrialEquip(equipUid)
	return tonumber(equipUid) == nil
end

function Season123EquipItemListModel:curSelectIsTrialEquip()
	local itemUid = self.curEquipMap[self.curSelectSlot]

	return itemUid and Season123EquipItemListModel.isTrialEquip(itemUid)
end

function Season123EquipItemListModel:curMapIsTrialEquipMap()
	if self.curPos == Season123EquipItemListModel.MainCharPos then
		local battleCO = HeroGroupModel.instance.battleConfig

		return battleCO and battleCO.trialMainAct104EuqipId > 0
	end

	local groupMO = self:getGroupMO()

	if not groupMO then
		return
	end

	local trialDict = groupMO.trialDict
	local index = self.curPos + 1
	local trialData = trialDict and trialDict[index]

	if trialData then
		local posMaxCount = self:getEquipMaxCount(index)

		for slot = 1, posMaxCount do
			local trialEquipId = HeroConfig.instance:getTrial104Equip(slot, trialData[1], trialData[2])

			if trialEquipId and trialEquipId > 0 then
				return true
			end
		end
	end
end

function Season123EquipItemListModel:isCardFitRole(itemCO)
	if self.curPos == Season123EquipItemListModel.MainCharPos then
		return Season123EquipMetaUtils.isMainRoleCard(itemCO)
	else
		return not Season123EquipMetaUtils.isMainRoleCard(itemCO)
	end
end

function Season123EquipItemListModel:isCardCanShowByTag(itemUid, itemTags)
	if self.tagModel then
		return self.tagModel:isCardNeedShow(itemTags)
	end

	return true
end

function Season123EquipItemListModel:refreshMergeList()
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

function Season123EquipItemListModel:changeSelectSlot(slotIndex)
	local posMaxCount = self:getEquipMaxCount(self.curPos)

	if slotIndex <= posMaxCount and slotIndex > 0 then
		self.curSelectSlot = slotIndex
	end
end

function Season123EquipItemListModel:getEquipMO(itemUid)
	return self._itemMap[itemUid]
end

function Season123EquipItemListModel:equipShowItem(itemUid)
	self.curEquipMap[self.curSelectSlot] = itemUid
end

function Season123EquipItemListModel:equipItem(itemUid, slot)
	self.curEquipMap[slot] = itemUid
	self.equipUid2Pos[itemUid] = self.curPos
	self.equipUid2Slot[itemUid] = slot
end

function Season123EquipItemListModel:unloadShowSlot(slot)
	self.curEquipMap[slot] = Activity123Enum.EmptyUid
end

function Season123EquipItemListModel:unloadItem(itemUid)
	self.equipUid2Pos[itemUid] = nil
	self.equipUid2Slot[itemUid] = nil

	local posMaxCount = self:getEquipMaxCount(self.curPos)

	for i = 1, posMaxCount do
		if self.curEquipMap[i] == itemUid then
			self.curEquipMap[i] = Activity123Enum.EmptyUid
		end
	end
end

function Season123EquipItemListModel:unloadItemByPos(targetPos, targetSlot)
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

function Season123EquipItemListModel:getItemUidByPos(targetPos, targetSlot)
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

function Season123EquipItemListModel:getItemEquipedPos(itemUid)
	return self.equipUid2Pos[itemUid], self.equipUid2Slot[itemUid]
end

function Season123EquipItemListModel:getCurItemEquip()
	local groupMO = self:getGroupMO()

	if not groupMO then
		return nil
	end

	local equipInfos = groupMO.activity104Equips

	for _, v in pairs(equipInfos) do
		if v.index == self.curPos then
			return v
		end
	end
end

function Season123EquipItemListModel:getEquipMaxCount(pos)
	return (pos == Season123EquipItemListModel.MainCharPos or nil) and (Activity123Enum.MainCardNum or Activity123Enum.HeroCardNum)
end

function Season123EquipItemListModel:getPosHeroUid(targetPos, groupIndex)
	local groupMO = self:getGroupMO(groupIndex)

	if not groupMO then
		return nil
	end

	return groupMO:getHeroByIndex(targetPos + 1)
end

function Season123EquipItemListModel:slotIsLock(slotIndex)
	return not self:isEquipCardPosUnlock(slotIndex, self.curPos)
end

function Season123EquipItemListModel:disableBecauseCareerNotFit(itemId)
	return self:isEquipCareerNoFit(itemId, self.curPos, self:getGroupMO())
end

function Season123EquipItemListModel:disableBecauseSameCard(itemUid)
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

function Season123EquipItemListModel:disableBecauseRole(itemId)
	local itemCo = Season123Config.instance:getSeasonEquipCo(itemId)

	if not itemCo then
		return false
	end

	local isMainRoleCard = Season123EquipMetaUtils.isMainRoleCard(itemCo)

	if self.curPos == Season123EquipItemListModel.MainCharPos then
		if isMainRoleCard then
			return false
		end
	elseif not isMainRoleCard then
		return false
	end

	return true
end

function Season123EquipItemListModel:disableBecausePos(itemId)
	local itemCo = Season123Config.instance:getSeasonEquipCo(itemId)

	if not itemCo then
		return false
	end

	local posDict, posStr = Season123Config.instance:getCardLimitPosDict(itemId)

	if posDict == nil or posDict[self.curPos + 1] then
		return false
	end

	return true, posStr
end

function Season123EquipItemListModel:isEquipCareerNoFit(itemId, pos, heroGroupMO)
	if pos == Season123EquipItemListModel.MainCharPos or not heroGroupMO then
		return false
	end

	local itemCO = Season123Config.instance:getSeasonEquipCo(itemId)

	if not itemCO then
		return false
	end

	local heroUid = heroGroupMO:getHeroByIndex(pos + 1)
	local heroMO

	if not string.nilorempty(heroUid) then
		heroMO = HeroModel.instance:getById(heroUid)
	end

	if not heroMO then
		return false
	end

	local targetCareer = heroMO.config.career

	if not string.nilorempty(itemCO.career) then
		if CharacterEnum.CareerType.Ling == targetCareer or CharacterEnum.CareerType.Zhi == targetCareer then
			return itemCO.career ~= Activity123Enum.CareerType.Ling_Or_Zhi
		else
			return tonumber(itemCO.career) ~= targetCareer
		end
	end

	return false
end

function Season123EquipItemListModel:isItemUidInShowSlot(itemUid)
	return self.curEquipMap[self.curSelectSlot] == itemUid
end

function Season123EquipItemListModel:isAllSlotEmpty()
	local equipCount = self:getEquipMaxCount(self.curPos)

	for slot = 1, equipCount do
		if self.curEquipMap[slot] ~= Activity123Enum.EmptyUid then
			return false
		end
	end

	return true
end

function Season123EquipItemListModel.sortItemMOList(a, b)
	local cfgA = Season123Config.instance:getSeasonEquipCo(a.itemId)
	local cfgB = Season123Config.instance:getSeasonEquipCo(b.itemId)

	if cfgA ~= nil and cfgB ~= nil then
		local rareFitA = Season123EquipItemListModel.instance:disableBecauseRole(a.itemId)
		local rareFitB = Season123EquipItemListModel.instance:disableBecauseRole(b.itemId)

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

function Season123EquipItemListModel:getGroupMO(groupIndex)
	return Season123HeroGroupModel.instance:getCurrentHeroGroup(groupIndex)
end

function Season123EquipItemListModel:flushSlot(slot)
	local itemUid = self.curEquipMap[slot]

	self:unloadItemByPos(self.curPos, slot)

	if itemUid ~= Activity123Enum.EmptyUid then
		self:unloadTeamLimitCard(itemUid)
		self:unloadItem(itemUid)
		self:equipItem(itemUid, slot)
	end
end

function Season123EquipItemListModel:unloadTeamLimitCard(targetItemUid)
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

function Season123EquipItemListModel:resumeSlotData()
	local slotMaxCount = self:getEquipMaxCount(self.curPos)

	for slotIndex = 1, slotMaxCount do
		self.curEquipMap[slotIndex] = self:getItemUidByPos(self.curPos, slotIndex)
	end
end

function Season123EquipItemListModel:flushGroup()
	return (self:packUpdateEquips())
end

function Season123EquipItemListModel:packUpdateEquips()
	local equipInfos = {}

	for pos = 1, Season123EquipItemListModel.TotalEquipPos do
		local heroUid = self:getPosHeroUid(pos - 1) or Activity123Enum.EmptyUid
		local info = {
			index = pos - 1,
			heroUid = heroUid,
			equipUid = {}
		}
		local slotMaxCount = self:getEquipMaxCount(pos - 1)

		for slot = 1, slotMaxCount do
			info.equipUid[slot] = Activity123Enum.EmptyUid
		end

		equipInfos[pos] = info
	end

	for itemUid, pos in pairs(self.equipUid2Pos) do
		if not Season123EquipItemListModel.isTrialEquip(itemUid) then
			local slot = self.equipUid2Slot[itemUid]

			if slot then
				equipInfos[pos + 1].equipUid[slot] = tostring(itemUid)
			end
		end
	end

	return equipInfos
end

function Season123EquipItemListModel:checkResetCurSelected()
	local posMaxCount = self:getEquipMaxCount(self.curPos)

	for i = 1, posMaxCount do
		if self.curEquipMap[i] ~= Activity123Enum.EmptyUid and not self._itemMap[self.curEquipMap[i]] then
			self.curEquipMap[i] = Activity123Enum.EmptyUid
		end
	end
end

function Season123EquipItemListModel:getShowUnlockSlotCount()
	local slotCount = 0

	for pos = 0, Season123EquipItemListModel.TotalEquipPos - 1 do
		local maxSlot = self:getEquipMaxCount(pos)

		for slot = maxSlot, 1, -1 do
			if self:isEquipCardPosUnlock(slot, pos) then
				slotCount = math.max(slotCount, slot)
			end
		end
	end

	return slotCount
end

function Season123EquipItemListModel:getNeedShowDeckCount(itemUid)
	local itemId = self._deckUidMap[itemUid]

	if itemId == nil then
		return false
	end

	local count = self._itemIdDeckCountMap[itemId]

	return count > 1, count
end

function Season123EquipItemListModel:getDelayPlayTime(mo)
	if mo == nil then
		return -1
	end

	if self.curPos == Season123EquipItemListModel.MainCharPos then
		if not SeasonEquipHeroViewContainer.ColumnCount then
			local columnCount = Season123EquipItemListModel.ColumnCount
			local curTime = Time.time

			if self._itemStartAnimTime == nil then
				self._itemStartAnimTime = curTime + Season123EquipItemListModel.OpenAnimStartTime
			end

			local index = self:getIndex(mo)

			if not index or index > Season123EquipItemListModel.AnimRowCount * columnCount then
				return -1
			end

			local delayTime = math.floor((index - 1) / columnCount) * Season123EquipItemListModel.OpenAnimTime + Season123EquipItemListModel.OpenAnimStartTime
			local passTime = curTime - self._itemStartAnimTime

			if delayTime < passTime then
				return -1
			else
				return delayTime - passTime
			end
		end
	end
end

function Season123EquipItemListModel:flushRecord()
	if self.recordNew then
		self.recordNew:recordAllItem()
	end
end

function Season123EquipItemListModel:isEquipCardPosUnlock(slot, pos)
	local posIndex = Season123Model.instance:getUnlockCardIndex(pos, slot)

	return self.curUnlockIndexSet[posIndex] == true
end

Season123EquipItemListModel.instance = Season123EquipItemListModel.New()

return Season123EquipItemListModel
