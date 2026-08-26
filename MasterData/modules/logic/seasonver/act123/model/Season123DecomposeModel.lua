-- chunkname: @modules/logic/seasonver/act123/model/Season123DecomposeModel.lua

module("modules.logic.seasonver.act123.model.Season123DecomposeModel", package.seeall)

local Season123DecomposeModel = class("Season123DecomposeModel", ListScrollModel)

function Season123DecomposeModel:onInit()
	self:release()
end

function Season123DecomposeModel:release()
	self._itemStartAnimTime = nil
	self._itemUid2HeroUid = nil
	self._itemMap = {}
	self.curSelectItemDict = {}
	self.curSelectItemCount = 0
	self.rareSelectTab = {}
	self.tagSelectTab = {}
	self.rareAscendState = false
	self.curOverPartSelectIndex = 1
	self.itemColunmCount = 6
	self.AnimRowCount = 4
	self.OpenAnimTime = 0.06
	self.OpenAnimStartTime = 0.05
end

function Season123DecomposeModel:clear()
	Season123DecomposeModel.super.clear(self)
end

function Season123DecomposeModel:initDatas(activityId)
	self.curActId = activityId
	self.curSelectItemDict = {}
	self.curSelectItemCount = 0
	self.rareSelectTab = {}
	self.tagSelectTab = {}
	self.rareAscendState = false
	self.curOverPartSelectIndex = self.curOverPartSelectIndex or 1
	self.itemColunmCount = 6

	self:initPosList()
	self:initList()
end

function Season123DecomposeModel:initList()
	local itemList = {}

	self._itemMap = Season123Model.instance:getAllItemMo(self.curActId) or {}

	for _, itemMO in pairs(self._itemMap) do
		local itemConfig = Season123Config.instance:getSeasonEquipCo(itemMO.itemId)

		if itemConfig and not Season123EquipMetaUtils.isBanActivity(itemConfig, self.curActId) and self:isCardCanShow(itemConfig) then
			table.insert(itemList, itemMO)
		end
	end

	table.sort(itemList, Season123DecomposeModel.sortItemMOList)
	self:setList(itemList)
end

function Season123DecomposeModel:initPosList()
	self._itemUid2HeroUid = {}

	local heroGroupList = Season123Model.instance:getSeasonAllHeroGroup(self.curActId)

	if not heroGroupList then
		return
	end

	for groupIndex, heroGroupMO in ipairs(heroGroupList) do
		local equips = heroGroupMO.activity104Equips

		if equips then
			self:parseHeroGroupEquips(heroGroupMO, equips)
		end
	end
end

function Season123DecomposeModel:parseHeroGroupEquips(heroGroupMO, equips)
	self._itemMap = Season123Model.instance:getAllItemMo(self.curActId) or {}

	for _, equipMO in pairs(equips) do
		local pos = equipMO.index
		local heroUid = heroGroupMO:getHeroByIndex(pos + 1)

		if pos == Activity123Enum.MainCharPos then
			heroUid = Activity123Enum.MainRoleHeroUid
		end

		if heroUid then
			for _, equipUid in pairs(equipMO.equipUid) do
				if equipUid ~= Activity123Enum.EmptyUid and (not self._itemUid2HeroUid[equipUid] or self._itemUid2HeroUid[equipUid] == Activity123Enum.EmptyUid) and self._itemMap[equipUid] ~= nil then
					self._itemUid2HeroUid[equipUid] = heroUid
				end
			end
		end
	end
end

function Season123DecomposeModel:isCardCanShow(itemConfig)
	local rare = itemConfig.rare
	local canShowByRare = self:isCardCanShowByRare(rare)
	local canShowByTag = self:isCardCanShowByTag(itemConfig)

	return canShowByRare and canShowByTag
end

function Season123DecomposeModel:isCardCanShowByRare(itemRare)
	local canShowState = false
	local hasShowState = false

	for rare, selectState in pairs(self.rareSelectTab) do
		if rare == itemRare then
			canShowState = selectState
		end

		if selectState then
			hasShowState = true
		end
	end

	return canShowState or not hasShowState
end

function Season123DecomposeModel:isCardCanShowByTag(itemConfig)
	local canShowState = false
	local hasShowState = false
	local tagList = string.split(itemConfig.tag, "#")

	for id, selectState in pairs(self.tagSelectTab) do
		for _, tagId in ipairs(tagList) do
			if self.tagSelectTab[tonumber(tagId)] then
				canShowState = true
			end
		end

		if selectState then
			hasShowState = true
		end
	end

	return canShowState or not hasShowState
end

function Season123DecomposeModel:getDelayPlayTime(mo)
	if mo == nil then
		return -1
	end

	local curTime = Time.time

	if self._itemStartAnimTime == nil then
		self._itemStartAnimTime = curTime + self.OpenAnimStartTime
	end

	local index = self:getIndex(mo)

	if not index or index > self.AnimRowCount * self.itemColunmCount then
		return -1
	end

	local delayTime = math.floor((index - 1) / self.itemColunmCount) * self.OpenAnimTime + self.OpenAnimStartTime
	local passTime = curTime - self._itemStartAnimTime

	if passTime - delayTime > 0.1 then
		return -1
	else
		return delayTime
	end
end

function Season123DecomposeModel:setItemCellCount(count)
	self.itemColunmCount = count or 6
end

function Season123DecomposeModel.sortItemMOList(a, b)
	local aEquiped = Season123DecomposeModel.instance:getItemUidToHeroUid(a.uid) ~= nil
	local bEquiped = Season123DecomposeModel.instance:getItemUidToHeroUid(b.uid) ~= nil
	local cfgA = Season123Config.instance:getSeasonEquipCo(a.itemId)
	local cfgB = Season123Config.instance:getSeasonEquipCo(b.itemId)

	if cfgA ~= nil and cfgB ~= nil then
		local isMainA = cfgA.isMain == Activity123Enum.isMainRole
		local isMainB = cfgB.isMain == Activity123Enum.isMainRole

		if isMainA ~= isMainB then
			return isMainA
		end

		if cfgA.rare ~= cfgB.rare then
			if Season123DecomposeModel.instance.rareAscendState then
				return cfgA.rare < cfgB.rare
			else
				return cfgA.rare > cfgB.rare
			end
		else
			if cfgA.equipId ~= cfgB.equipId then
				return cfgA.equipId > cfgB.equipId
			end

			local aSelected = Season123DecomposeModel.instance.curSelectItemDict[a.uid] ~= nil and Season123DecomposeModel.instance.curSelectItemDict[a.uid] ~= false
			local bSelected = Season123DecomposeModel.instance.curSelectItemDict[b.uid] ~= nil and Season123DecomposeModel.instance.curSelectItemDict[b.uid] ~= false

			if aSelected ~= bSelected then
				return aSelected
			end

			if aEquiped ~= bEquiped then
				return bEquiped
			end

			return a.uid < b.uid
		end
	else
		return a.uid < b.uid
	end
end

function Season123DecomposeModel:getItemUidToHeroUid(itemUid)
	return self._itemUid2HeroUid[itemUid]
end

function Season123DecomposeModel:setCurSelectItemUid(itemUid)
	if not self.curSelectItemDict[itemUid] then
		self.curSelectItemDict[itemUid] = self._itemMap[itemUid]
		self.curSelectItemCount = self.curSelectItemCount + 1
	else
		self.curSelectItemDict[itemUid] = nil
		self.curSelectItemCount = self.curSelectItemCount - 1
	end
end

function Season123DecomposeModel:isSelectedItem(itemUid)
	return self.curSelectItemDict[itemUid] ~= nil
end

function Season123DecomposeModel:clearCurSelectItem()
	self.curSelectItemDict = {}
	self.curSelectItemCount = 0
end

function Season123DecomposeModel:setRareSelectItem(selectTab)
	for rare, selectState in pairs(selectTab) do
		self.rareSelectTab[rare] = selectState
	end
end

function Season123DecomposeModel:setTagSelectItem(selectTab)
	for tagId, selectState in pairs(selectTab) do
		self.tagSelectTab[tagId] = selectState
	end
end

function Season123DecomposeModel:hasSelectFilterItem()
	if GameUtil.getTabLen(self.rareSelectTab) > 0 then
		for rare, selectState in pairs(self.rareSelectTab) do
			if selectState then
				return true
			end
		end
	end

	if GameUtil.getTabLen(self.tagSelectTab) > 0 then
		for id, selectState in pairs(self.tagSelectTab) do
			if selectState then
				return true
			end
		end
	end

	return false
end

function Season123DecomposeModel:setRareAscendState(isAscend)
	self.rareAscendState = isAscend
end

function Season123DecomposeModel:sortDecomposeItemListByRare()
	local itemList = self:getList()

	table.sort(itemList, Season123DecomposeModel.sortItemMOList)
	self:setList(itemList)
end

function Season123DecomposeModel:setCurOverPartSelectIndex(index)
	self.curOverPartSelectIndex = index
end

function Season123DecomposeModel:selectOverPartItem()
	if self:getCount() == 0 then
		return
	end

	self:clearCurSelectItem()

	local equipBookListCount = Season123EquipBookModel.instance:getCount()

	if equipBookListCount == 0 then
		Season123EquipBookModel.instance:initDatas(self.curActId)
	end

	Season123EquipBookModel.instance:getAllEquipItem()

	local itemList = self:getList()
	local selectItemCount = 0
	local preItemId = -1

	for id, itemMO in pairs(itemList) do
		local equipBookMO = Season123EquipBookModel.instance.allEquipItemMap[itemMO.itemId]
		local itemCount = equipBookMO.count
		local overCount = itemCount - self.curOverPartSelectIndex

		if itemMO.itemId ~= preItemId then
			preItemId = itemMO.itemId
			selectItemCount = 0
		end

		if overCount > 0 and selectItemCount < overCount and not self:isSelectItemMaxCount() then
			self.curSelectItemDict[itemMO.uid] = itemMO
			selectItemCount = selectItemCount + 1
			self.curSelectItemCount = self.curSelectItemCount + 1
		end
	end
end

function Season123DecomposeModel:isSelectItemMaxCount()
	return self.curSelectItemCount >= Activity123Enum.maxDecomposeCount
end

function Season123DecomposeModel:getDecomposeItemsByItemId(curActId, itemId)
	self._itemMap = Season123Model.instance:getAllItemMo(curActId) or {}

	if GameUtil.getTabLen(self._itemMap) == 0 then
		return nil
	end

	local decomposeItemCount = self:getCount()

	if decomposeItemCount == 0 then
		self:initDatas(curActId)
	end

	local itemList = {}
	local decomposeItemDict = self:getDict()

	for index, itemMO in pairs(decomposeItemDict) do
		if itemMO.itemId == itemId then
			table.insert(itemList, itemMO)
		end
	end

	return itemList
end

function Season123DecomposeModel:isDecomposeItemUsedByHero(itemTab)
	for id, itemMO in pairs(itemTab) do
		local hasUsedItem = self:getItemUidToHeroUid(itemMO.uid)

		if hasUsedItem and hasUsedItem ~= Activity123Enum.EmptyUid then
			return true
		end
	end

	return false
end

function Season123DecomposeModel:removeHasDecomposeItems(hasDecomposedItemList)
	for index, itemUid in ipairs(hasDecomposedItemList) do
		self.curSelectItemDict[itemUid] = nil
		self._itemMap[itemUid] = nil
	end
end

Season123DecomposeModel.instance = Season123DecomposeModel.New()

return Season123DecomposeModel
