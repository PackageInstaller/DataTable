-- chunkname: @modules/logic/season/model/Activity104EquipItemComposeModel.lua

module("modules.logic.season.model.Activity104EquipItemComposeModel", package.seeall)

local Activity104EquipItemComposeModel = class("Activity104EquipItemComposeModel", ListScrollModel)

Activity104EquipItemComposeModel.ComposeMaxCount = 3
Activity104EquipItemComposeModel.EmptyUid = "0"
Activity104EquipItemComposeModel.MainRoleHeroUid = "main_role"

function Activity104EquipItemComposeModel:initDatas(activityId)
	self.activityId = activityId

	self:clearSelectMap()
	self:initSubModel()
	self:initItemMap()
	self:initPosList()
	self:initList()
end

function Activity104EquipItemComposeModel:clear()
	Activity104EquipItemComposeModel.super.clear(self)

	self.curSelectMap = nil
	self._curSelectUidPosSet = nil
	self._itemUid2HeroUid = nil
	self._itemMap = nil
	self._itemDefaultList = {}
	self._itemStartAnimTime = nil
	self.tagModel = nil
	self.countModel = nil
	self._itemCountDict = nil
end

function Activity104EquipItemComposeModel:clearSelectMap()
	self.curSelectMap = {}
	self._curSelectUidPosSet = {}

	for pos = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		self.curSelectMap[pos] = Activity104EquipItemComposeModel.EmptyUid
	end
end

function Activity104EquipItemComposeModel:initSubModel()
	self.tagModel = Activity104EquipTagModel.New()

	self.tagModel:init(self.activityId)

	self.countModel = Activity104EquipCountModel.New()

	self.countModel:init(self.activityId)
end

function Activity104EquipItemComposeModel:initItemMap()
	self._itemMap = Activity104Model.instance:getAllItemMo(self.activityId) or {}

	self:initDefaultList()

	if self.countModel then
		self.countModel:refreshData(self._itemDefaultList)
	end
end

function Activity104EquipItemComposeModel:initPosList()
	self._itemUid2HeroUid = {}

	local heroGroupList = Activity104Model.instance:getSeasonAllHeroGroup(self.activityId)

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

function Activity104EquipItemComposeModel:parseHeroGroupEquips(heroGroupMO, equips)
	for _, equipMO in pairs(equips) do
		local pos = equipMO.index
		local heroUid = heroGroupMO:getHeroByIndex(pos + 1)

		if pos == Activity104EquipItemListModel.MainCharPos then
			heroUid = Activity104EquipItemComposeModel.MainRoleHeroUid
		end

		if heroUid then
			for _, equipUid in pairs(equipMO.equipUid) do
				if equipUid ~= Activity104EquipItemComposeModel.EmptyUid and (not self._itemUid2HeroUid[equipUid] or self._itemUid2HeroUid[equipUid] == Activity104EquipItemComposeModel.EmptyUid) and self._itemMap[equipUid] ~= nil then
					self._itemUid2HeroUid[equipUid] = heroUid
				end
			end
		end
	end
end

function Activity104EquipItemComposeModel:initDefaultList()
	local list = {}

	for itemUid, itemMO in pairs(self._itemMap) do
		if not SeasonConfig.instance:getEquipIsOptional(itemMO.itemId) then
			local itemCO = SeasonConfig.instance:getSeasonEquipCo(itemMO.itemId)

			if itemCO and not SeasonEquipMetaUtils.isBanActivity(itemCO, self.activityId) and itemCO.rare ~= Activity104Enum.MainRoleRare then
				local mo = Activity104EquipComposeMo.New()

				mo:init(itemMO)
				table.insert(list, mo)
			end
		end
	end

	self._itemDefaultList = list
end

function Activity104EquipItemComposeModel:initList()
	self._itemCountDict = {}

	local list = {}

	for _, mo in pairs(self._itemDefaultList) do
		local itemCO = SeasonConfig.instance:getSeasonEquipCo(mo.itemId)

		if itemCO and self:isCardCanShow(itemCO) then
			table.insert(list, mo)
			self:_addItemToCountDict(mo.itemId)
		end
	end

	table.sort(list, Activity104EquipItemComposeModel.sortItemMOList)
	self:setList(list)
end

function Activity104EquipItemComposeModel:_addItemToCountDict(itemId)
	self._itemCountDict = self._itemCountDict or {}
	self._itemCountDict[itemId] = self._itemCountDict[itemId] or 0
	self._itemCountDict[itemId] = self._itemCountDict[itemId] + 1
end

function Activity104EquipItemComposeModel:_getItemCount(itemId)
	self._itemCountDict = self._itemCountDict or {}

	return self._itemCountDict[itemId] or 0
end

function Activity104EquipItemComposeModel:isCardCanShow(itemCo)
	local flag1 = self.tagModel:isCardNeedShow(itemCo.tag)
	local flag2 = self.countModel:isCardNeedShow(itemCo.equipId, self:_getItemCount(itemCo.equipId))

	return flag1 and flag2
end

function Activity104EquipItemComposeModel.sortItemMOList(a, b)
	local aEquiped = Activity104EquipItemComposeModel.instance:getEquipedHeroUid(a.id) ~= nil
	local bEquiped = Activity104EquipItemComposeModel.instance:getEquipedHeroUid(b.id) ~= nil

	if aEquiped ~= bEquiped then
		return bEquiped
	end

	local cfgA = SeasonConfig.instance:getSeasonEquipCo(a.itemId)
	local cfgB = SeasonConfig.instance:getSeasonEquipCo(b.itemId)

	if cfgA ~= nil and cfgB ~= nil then
		if cfgA.rare ~= cfgB.rare then
			return cfgA.rare > cfgB.rare
		else
			return cfgA.equipId > cfgB.equipId
		end
	else
		return a.id < b.id
	end
end

function Activity104EquipItemComposeModel:checkResetCurSelected()
	for pos = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		local itemUid = self.curSelectMap[pos]

		if not self._itemMap[itemUid] then
			self.curSelectMap[pos] = Activity104EquipItemComposeModel.EmptyUid
		end
	end
end

function Activity104EquipItemComposeModel:setSelectEquip(itemUid)
	for pos = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		if Activity104EquipItemComposeModel.EmptyUid == self.curSelectMap[pos] then
			self:selectEquip(itemUid, pos)

			return true
		end
	end

	return false
end

function Activity104EquipItemComposeModel:selectEquip(itemUid, pos)
	self.curSelectMap[pos] = itemUid
	self._curSelectUidPosSet[itemUid] = pos
end

function Activity104EquipItemComposeModel:getEquipMO(itemUid)
	return self._itemMap[itemUid]
end

function Activity104EquipItemComposeModel:unloadEquip(itemUid)
	local pos = self._curSelectUidPosSet[itemUid]

	if pos then
		self.curSelectMap[pos] = Activity104EquipItemComposeModel.EmptyUid
		self._curSelectUidPosSet[itemUid] = nil
	end
end

function Activity104EquipItemComposeModel:getEquipedHeroUid(itemUid)
	return self._itemUid2HeroUid[itemUid]
end

function Activity104EquipItemComposeModel:isEquipSelected(itemUid)
	return self._curSelectUidPosSet[itemUid] ~= nil
end

function Activity104EquipItemComposeModel:existSelectedMaterial()
	for pos = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		if self.curSelectMap[pos] ~= Activity104EquipItemComposeModel.EmptyUid then
			return true
		end
	end

	return false
end

function Activity104EquipItemComposeModel:getSelectedRare()
	for pos = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		local itemUid = self.curSelectMap[pos]

		if itemUid ~= Activity104EquipItemComposeModel.EmptyUid then
			local itemMO = self:getEquipMO(itemUid)
			local itemCo = SeasonConfig.instance:getSeasonEquipCo(itemMO.itemId)

			if itemCo then
				return itemCo.rare
			end
		end
	end
end

function Activity104EquipItemComposeModel:isMaterialAllReady()
	for pos = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		if self.curSelectMap[pos] == Activity104EquipItemComposeModel.EmptyUid then
			return false
		end
	end

	return true
end

function Activity104EquipItemComposeModel:getMaterialList()
	local list = {}

	for pos = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
		table.insert(list, self.curSelectMap[pos])
	end

	return list
end

function Activity104EquipItemComposeModel:getDelayPlayTime(mo)
	if mo == nil then
		return -1
	end

	local curTime = Time.time

	if self._itemStartAnimTime == nil then
		self._itemStartAnimTime = curTime + SeasonEquipComposeItem.OpenAnimStartTime
	end

	local index = self:getIndex(mo)

	if not index or index > SeasonEquipComposeItem.AnimRowCount * SeasonEquipComposeItem.ColumnCount then
		return -1
	end

	local delayTime = math.floor((index - 1) / SeasonEquipComposeItem.ColumnCount) * SeasonEquipComposeItem.OpenAnimTime + SeasonEquipComposeItem.OpenAnimStartTime
	local passTime = curTime - self._itemStartAnimTime

	if delayTime < passTime then
		return -1
	else
		return delayTime - passTime
	end
end

function Activity104EquipItemComposeModel:checkAutoSelectEquip()
	self:clearSelectMap()

	local list = self:getList()
	local itemList = {}

	for _, mo in pairs(list) do
		table.insert(itemList, mo)
	end

	table.sort(itemList, Activity104EquipItemComposeModel.sortAutoSelectItemMOList)

	local rareDict = {}
	local rareList = {}

	for i, v in ipairs(itemList) do
		local cfg = SeasonConfig.instance:getSeasonEquipCo(v.itemId)

		if not rareDict[cfg.rare] then
			rareDict[cfg.rare] = {}

			table.insert(rareList, cfg.rare)
		end

		table.insert(rareDict[cfg.rare], v)
	end

	table.sort(rareList, function(a, b)
		return a < b
	end)

	local result = false

	for _, v in ipairs(rareList) do
		local rareItemList = rareDict[v]

		if #rareItemList >= Activity104EquipItemComposeModel.ComposeMaxCount then
			result = true

			for i = 1, Activity104EquipItemComposeModel.ComposeMaxCount do
				self:setSelectEquip(rareItemList[i].id)
			end

			break
		end
	end

	return result
end

function Activity104EquipItemComposeModel.sortAutoSelectItemMOList(a, b)
	local cfgA = SeasonConfig.instance:getSeasonEquipCo(a.itemId)
	local cfgB = SeasonConfig.instance:getSeasonEquipCo(b.itemId)

	if cfgA ~= nil and cfgB ~= nil then
		if cfgA.rare ~= cfgB.rare then
			return cfgA.rare < cfgB.rare
		else
			return cfgA.equipId < cfgB.equipId
		end
	else
		return a.id < b.id
	end
end

Activity104EquipItemComposeModel.instance = Activity104EquipItemComposeModel.New()

return Activity104EquipItemComposeModel
