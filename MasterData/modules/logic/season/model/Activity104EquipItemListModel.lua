-- chunkname: @modules/logic/season/model/Activity104EquipItemListModel.lua

module("modules.logic.season.model.Activity104EquipItemListModel", package.seeall)

local Activity104EquipItemListModel = class("Activity104EquipItemListModel", ListScrollModel)

Activity104EquipItemListModel.MainCharPos = 4
Activity104EquipItemListModel.TotalEquipPos = 5
Activity104EquipItemListModel.MaxPos = 2
Activity104EquipItemListModel.HeroMaxPos = 1
Activity104EquipItemListModel.EmptyUid = "0"

function Activity104EquipItemListModel:clear()
	Activity104EquipItemListModel.super.clear(self)

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

function Activity104EquipItemListModel:initDatas(activityId, groupIndex, posIndex, slotIndex)
	logNormal("Activity104EquipItemListModel initDatas")
	self:clear()

	self.activityId = activityId
	self.curPos = posIndex
	self.groupIndex = groupIndex
	self.equipUid2Pos = {}
	self.equipUid2Slot = {}

	local posMaxCount = self:getEquipMaxCount(self.curPos)

	self.curEquipMap = {}

	for i = 1, posMaxCount do
		self.curEquipMap[i] = Activity104EquipItemListModel.EmptyUid
	end

	self.curSelectSlot = slotIndex or 1
	self.equipUid2Group = {}

	self:initSubModel()
	self:initItemMap()
	self:initPlayerPrefs()
	self:initPosData()
	self:initList()
end

function Activity104EquipItemListModel:initSubModel()
	self.tagModel = Activity104EquipTagModel.New()

	self.tagModel:init(self.activityId)
end

function Activity104EquipItemListModel:initItemMap()
	self._itemMap = Activity104Model.instance:getAllItemMo(self.activityId) or {}
end

function Activity104EquipItemListModel:initPlayerPrefs()
	self.recordNew = SeasonEquipLocalRecord.New()

	self.recordNew:init(self.activityId, Activity104Enum.PlayerPrefsKeyItemUid)
end

function Activity104EquipItemListModel.getTrialEquipUID(...)
	local t = {
		...
	}

	return table.concat(t, "#")
end

function Activity104EquipItemListModel.isTrialEquip(equipUid)
	return tonumber(equipUid) == nil
end

function Activity104EquipItemListModel:curSelectIsTrialEquip()
	local itemUid = self.curEquipMap[self.curSelectSlot]

	return itemUid and Activity104EquipItemListModel.isTrialEquip(itemUid)
end

function Activity104EquipItemListModel:curMapIsTrialEquipMap()
	if self.curPos == Activity104EquipItemListModel.MainCharPos then
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

function Activity104EquipItemListModel:initPosData()
	local groupMO = self:getGroupMO()

	if not groupMO then
		return
	end

	local equipInfos = groupMO.activity104Equips

	for pos, equipGroupMO in pairs(equipInfos) do
		local posMaxCount = self:getEquipMaxCount(pos)

		for i = 1, posMaxCount do
			local equipUid = equipGroupMO.equipUid[i]

			if self._itemMap[equipUid] then
				self:setCardPosData(equipUid, pos, i)
			end
		end
	end

	local trialDict = groupMO.trialDict

	if trialDict then
		for index, v in pairs(trialDict) do
			local pos = index - 1
			local posMaxCount = self:getEquipMaxCount(pos)

			for slot = 1, posMaxCount do
				local trialEquipId = HeroConfig.instance:getTrial104Equip(slot, v[1], v[2])

				if trialEquipId and trialEquipId > 0 then
					local equipUid = Activity104EquipItemListModel.getTrialEquipUID(trialEquipId, slot, v[1])

					self:setCardPosData(equipUid, pos, slot)
				end
			end
		end
	end

	local battleCO = HeroGroupModel.instance.battleConfig

	if battleCO and battleCO.trialMainAct104EuqipId > 0 then
		local slot = 1
		local equipUid = Activity104EquipItemListModel.getTrialEquipUID(battleCO.trialMainAct104EuqipId, slot)

		self:setCardPosData(equipUid, Activity104EquipItemListModel.MainCharPos, slot)
	end
end

function Activity104EquipItemListModel:setCardPosData(equipUid, pos, slot)
	self:clearCardPosSlot(pos, slot)

	self.equipUid2Pos[equipUid] = pos
	self.equipUid2Slot[equipUid] = slot

	if pos == self.curPos then
		self.curEquipMap[slot] = equipUid
	end
end

function Activity104EquipItemListModel:clearCardPosSlot(pos, slot)
	local sameUid

	for uid, _pos in pairs(self.equipUid2Pos) do
		local _slot = self.equipUid2Slot[uid]

		if _pos == pos and _slot == slot then
			sameUid = uid

			break
		end
	end

	if sameUid then
		self.equipUid2Pos[sameUid] = nil
		self.equipUid2Slot[sameUid] = nil
	end
end

function Activity104EquipItemListModel:initList()
	local list = {}

	for itemUid, itemMO in pairs(self._itemMap) do
		self:setListData(itemMO.itemId, itemUid, itemMO, list)
	end

	local groupMO = self:getGroupMO()

	if groupMO then
		local trialDict = groupMO.trialDict

		if trialDict then
			for k, v in pairs(trialDict) do
				for slot = 1, Activity104EquipItemListModel.MaxPos do
					local trialEquipId = HeroConfig.instance:getTrial104Equip(slot, v[1], v[2])

					if trialEquipId and trialEquipId > 0 then
						local itemUid = Activity104EquipItemListModel.getTrialEquipUID(trialEquipId, slot, v[1])

						self:setListData(trialEquipId, itemUid, nil, list)
					end
				end
			end
		end
	end

	local battleCO = HeroGroupModel.instance.battleConfig

	if battleCO and battleCO.trialMainAct104EuqipId > 0 then
		local slot = 1
		local equipUid = Activity104EquipItemListModel.getTrialEquipUID(battleCO.trialMainAct104EuqipId, slot)

		self:setListData(battleCO.trialMainAct104EuqipId, equipUid, nil, list)
	end

	table.sort(list, Activity104EquipItemListModel.sortItemMOList)

	self._originList = list

	self:refreshMergeList()
end

function Activity104EquipItemListModel:setListData(itemId, itemUid, itemMO, list)
	if not SeasonConfig.instance:getEquipIsOptional(itemId) then
		local itemCO = SeasonConfig.instance:getSeasonEquipCo(itemId)

		if itemCO and self:isCardFitRole(itemCO) and self:isCardCanShowByTag(itemUid, itemCO.tag) then
			self.equipUid2Group[itemUid] = itemCO.group

			if not itemMO then
				itemMO = Activity104ItemMo.New()

				itemMO:init({
					quantity = 1,
					itemId = itemId,
					uid = itemUid
				})
			end

			local mo = Activity104EquipListMo.New()

			mo:init(itemMO)
			table.insert(list, mo)
		end
	end
end

function Activity104EquipItemListModel:isCardFitRole(itemCO)
	if self.curPos == Activity104EquipItemListModel.MainCharPos then
		return SeasonEquipMetaUtils.isMainRoleCard(itemCO.rare)
	else
		return not SeasonEquipMetaUtils.isMainRoleCard(itemCO.rare)
	end
end

function Activity104EquipItemListModel:isCardCanShowByTag(itemUid, itemTags)
	if self.tagModel then
		return self.tagModel:isCardNeedShow(itemTags)
	end

	return true
end

function Activity104EquipItemListModel:refreshMergeList()
	local list = {}
	local curSelectIdMap = {}
	local itemIdCountMap = {}
	local deckIdMap = {}

	for k, v in pairs(self.curEquipMap) do
		if v ~= Activity104EquipItemListModel.EmptyUid then
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

function Activity104EquipItemListModel:changeSelectSlot(slotIndex)
	local posMaxCount = self:getEquipMaxCount(self.curPos)

	if slotIndex <= posMaxCount and slotIndex > 0 then
		self.curSelectSlot = slotIndex
	end
end

function Activity104EquipItemListModel:getEquipMO(itemUid)
	return self._itemMap[itemUid]
end

function Activity104EquipItemListModel:equipShowItem(itemUid)
	self.curEquipMap[self.curSelectSlot] = itemUid
end

function Activity104EquipItemListModel:equipItem(itemUid, slot)
	self.curEquipMap[slot] = itemUid
	self.equipUid2Pos[itemUid] = self.curPos
	self.equipUid2Slot[itemUid] = slot
end

function Activity104EquipItemListModel:unloadShowSlot(slot)
	self.curEquipMap[slot] = Activity104EquipItemListModel.EmptyUid
end

function Activity104EquipItemListModel:unloadItem(itemUid)
	self.equipUid2Pos[itemUid] = nil
	self.equipUid2Slot[itemUid] = nil

	local posMaxCount = self:getEquipMaxCount(self.curPos)

	for i = 1, posMaxCount do
		if self.curEquipMap[i] == itemUid then
			self.curEquipMap[i] = Activity104EquipItemListModel.EmptyUid
		end
	end
end

function Activity104EquipItemListModel:unloadItemByPos(targetPos, targetSlot)
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

function Activity104EquipItemListModel:getItemUidByPos(targetPos, targetSlot)
	for itemUid, oldPos in pairs(self.equipUid2Pos) do
		if oldPos == targetPos then
			local slot = self.equipUid2Slot[itemUid]

			if slot == targetSlot then
				return itemUid
			end
		end
	end

	return Activity104EquipItemListModel.EmptyUid
end

function Activity104EquipItemListModel:getItemEquipedPos(itemUid)
	return self.equipUid2Pos[itemUid], self.equipUid2Slot[itemUid]
end

function Activity104EquipItemListModel:getCurItemEquip()
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

function Activity104EquipItemListModel:getEquipMaxCount(pos)
	return (pos == Activity104EquipItemListModel.MainCharPos or nil) and (Activity104EquipItemListModel.HeroMaxPos or Activity104EquipItemListModel.MaxPos)
end

function Activity104EquipItemListModel:getPosHeroUid(targetPos, groupIndex)
	local groupMO = self:getGroupMO(groupIndex)

	if not groupMO then
		return nil
	end

	return groupMO:getHeroByIndex(targetPos + 1)
end

function Activity104EquipItemListModel:slotIsLock(slotIndex)
	local isPosUnlock = Activity104Model.instance:isSeasonPosUnlock(self.activityId, self.groupIndex, slotIndex, self.curPos)
	local trialCount = self:getTrialEquipCountByPos(self.curPos)
	local isTrialPosUnlock = slotIndex <= trialCount

	return not isPosUnlock and not isTrialPosUnlock
end

function Activity104EquipItemListModel:disableBecauseCareerNotFit(itemId)
	return self:isEquipCareerNoFit(itemId, self.curPos, self:getGroupMO())
end

function Activity104EquipItemListModel:disableBecauseSameCard(itemUid)
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

function Activity104EquipItemListModel:disableBecauseRole(itemId)
	local itemCo = SeasonConfig.instance:getSeasonEquipCo(itemId)

	if not itemCo then
		return false
	end

	local isMainRoleCard = SeasonEquipMetaUtils.isMainRoleCard(itemCo.rare)

	if self.curPos == Activity104EquipItemListModel.MainCharPos then
		if isMainRoleCard then
			return false
		end
	elseif not isMainRoleCard then
		return false
	end

	return true
end

function Activity104EquipItemListModel:isEquipCareerNoFit(itemId, pos, heroGroupMO)
	if pos == Activity104EquipItemListModel.MainCharPos or not heroGroupMO then
		return false
	end

	local itemCO = SeasonConfig.instance:getSeasonEquipCo(itemId)

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
			return itemCO.career ~= Activity104Enum.CareerType.Ling_Or_Zhi
		else
			return tonumber(itemCO.career) ~= targetCareer
		end
	end

	return false
end

function Activity104EquipItemListModel:isItemUidInShowSlot(itemUid)
	return self.curEquipMap[self.curSelectSlot] == itemUid
end

function Activity104EquipItemListModel:isAllSlotEmpty()
	local equipCount = self:getEquipMaxCount(self.curPos)

	for slot = 1, equipCount do
		if self.curEquipMap[slot] ~= Activity104EquipItemListModel.EmptyUid then
			return false
		end
	end

	return true
end

function Activity104EquipItemListModel.sortItemMOList(a, b)
	local cfgA = SeasonConfig.instance:getSeasonEquipCo(a.itemId)
	local cfgB = SeasonConfig.instance:getSeasonEquipCo(b.itemId)

	if cfgA ~= nil and cfgB ~= nil then
		local rareFitA = Activity104EquipItemListModel.instance:disableBecauseRole(a.itemId)
		local rareFitB = Activity104EquipItemListModel.instance:disableBecauseRole(b.itemId)

		if rareFitB ~= rareFitA then
			return rareFitB
		end

		if cfgA.rare ~= cfgB.rare then
			return cfgA.rare > cfgB.rare
		else
			return cfgA.equipId > cfgB.equipId
		end
	else
		return a.itemUid < b.itemUid
	end
end

function Activity104EquipItemListModel:getGroupMO(groupIndex)
	return HeroGroupModel.instance:getCurGroupMO()
end

function Activity104EquipItemListModel:flushSlot(slot)
	local itemUid = self.curEquipMap[slot]

	self:unloadItemByPos(self.curPos, slot)

	if itemUid ~= Activity104EquipItemListModel.EmptyUid then
		self:unloadItem(itemUid)
		self:equipItem(itemUid, slot)
	end
end

function Activity104EquipItemListModel:resumeSlotData()
	local slotMaxCount = self:getEquipMaxCount(self.curPos)

	for slotIndex = 1, slotMaxCount do
		self.curEquipMap[slotIndex] = self:getItemUidByPos(self.curPos, slotIndex)
	end
end

function Activity104EquipItemListModel:flushGroup()
	return (self:packUpdateEquips())
end

function Activity104EquipItemListModel:packUpdateEquips()
	local equipInfos = {}

	for pos = 1, Activity104EquipItemListModel.TotalEquipPos do
		local heroUid = self:getPosHeroUid(pos - 1) or Activity104EquipItemListModel.EmptyUid
		local info = {
			index = pos - 1,
			heroUid = heroUid,
			equipUid = {}
		}
		local slotMaxCount = self:getEquipMaxCount(pos - 1)

		for slot = 1, slotMaxCount do
			info.equipUid[slot] = Activity104EquipItemListModel.EmptyUid
		end

		equipInfos[pos] = info
	end

	for itemUid, pos in pairs(self.equipUid2Pos) do
		if not Activity104EquipItemListModel.isTrialEquip(itemUid) then
			local slot = self.equipUid2Slot[itemUid]

			if slot then
				equipInfos[pos + 1].equipUid[slot] = itemUid
			end
		end
	end

	return equipInfos
end

function Activity104EquipItemListModel:checkResetCurSelected()
	local posMaxCount = self:getEquipMaxCount(self.curPos)

	for i = 1, posMaxCount do
		if self.curEquipMap[i] ~= Activity104EquipItemListModel.EmptyUid and not self._itemMap[self.curEquipMap[i]] then
			self.curEquipMap[i] = Activity104EquipItemListModel.EmptyUid
		end
	end
end

function Activity104EquipItemListModel:getShowUnlockSlotCount()
	local slotCount = 0

	for pos = 0, Activity104EquipItemListModel.TotalEquipPos - 1 do
		local maxSlot = self:getEquipMaxCount(pos)

		for slot = maxSlot, 1, -1 do
			if Activity104Model.instance:isSeasonPosUnlock(self.activityId, self.groupIndex, slot, pos) then
				slotCount = math.max(slotCount, slot)
			end
		end

		local trialEquipCount = self:getTrialEquipCountByPos(pos)

		slotCount = math.max(slotCount, trialEquipCount)
	end

	return slotCount
end

function Activity104EquipItemListModel:getTrialEquipCountByPos(pos)
	local count = 0
	local groupMO = self:getGroupMO()

	if not groupMO then
		return count
	end

	local trialDict = groupMO.trialDict
	local curTrial = trialDict and trialDict[pos + 1]

	if curTrial then
		local posMaxCount = self:getEquipMaxCount(pos)

		for slot = 1, posMaxCount do
			local trialEquipId = HeroConfig.instance:getTrial104Equip(slot, curTrial[1], curTrial[2])

			if trialEquipId and trialEquipId > 0 then
				count = count + 1
			end
		end
	end

	return count
end

function Activity104EquipItemListModel:getNeedShowDeckCount(itemUid)
	local itemId = self._deckUidMap[itemUid]

	if itemId == nil then
		return false
	end

	local count = self._itemIdDeckCountMap[itemId]

	return count > 1, count
end

function Activity104EquipItemListModel:getDelayPlayTime(mo)
	if mo == nil then
		return -1
	end

	if self.curPos == Activity104EquipItemListModel.MainCharPos then
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

function Activity104EquipItemListModel:flushRecord()
	if self.recordNew then
		self.recordNew:recordAllItem()
	end
end

function Activity104EquipItemListModel:fiterFightCardDataList(equips, trialHeroList)
	local dataList = {}
	local trialDict = {}

	if trialHeroList then
		local battleId = FightModel.instance:getBattleId()
		local battleCO = battleId and lua_battle.configDict[battleId]

		if battleCO then
			if not battleCO.playerMax then
				local playerMax = ModuleEnum.HeroCountInGroup

				for i, v in ipairs(trialHeroList) do
					local pos = v.pos

					if pos < 0 then
						pos = playerMax - pos
					end

					trialDict[pos] = v.trialId
				end
			end
		end
	end

	self:_fiterFightCardData(Activity104EquipItemListModel.TotalEquipPos, dataList, equips)

	for index = 1, Activity104EquipItemListModel.TotalEquipPos - 1 do
		self:_fiterFightCardData(index, dataList, equips, trialDict)
	end

	return dataList
end

function Activity104EquipItemListModel:_fiterFightCardData(index, list, equips, trialDict)
	local pos = index - 1
	local trialId = trialDict and trialDict[index]

	if equips then
		::label_50_0::

		local var_50_0 = equips[index]

		if equips[index] then
			local heroUid = equips[index].heroUid

			if pos == Activity104EquipItemListModel.MainCharPos then
				heroUid = nil
			end

			local nullHero = not heroUid or heroUid == Activity104EquipItemListModel.EmptyUid

			if nullHero and pos ~= Activity104EquipItemListModel.MainCharPos then
				return
			end

			local maxSlot = self:getEquipMaxCount(pos)
			local count = 1

			for slot = 1, maxSlot do
				if equips then
					::label_50_1::

					local var_50_1 = equips[index]

					if equips[index] then
						var_50_1 = equips[index].equipUid

						if equips[index].equipUid then
							local equipUid = equips[index].equipUid[slot]
							local equipId

							if equipUid then
								equipId = Activity104Model.instance:getItemIdByUid(equipUid)
							end

							if not equipId or equipId == 0 then
								if trialId then
									equipId = HeroConfig.instance:getTrial104Equip(slot, trialId)
								elseif pos == Activity104EquipItemListModel.MainCharPos then
									local battleId = FightModel.instance:getBattleId()
									local battleCO = battleId and lua_battle.configDict[battleId]

									equipId = battleCO and battleCO.trialMainAct104EuqipId
								end
							end

							if equipId and equipId > 0 then
								local data = {}

								data.equipId = equipId
								data.heroUid = heroUid
								data.trialId = trialId
								data.count = count
								count = count + 1

								table.insert(list, data)
							end
						end
					end
				end
			end
		end
	end
end

Activity104EquipItemListModel.instance = Activity104EquipItemListModel.New()

return Activity104EquipItemListModel
