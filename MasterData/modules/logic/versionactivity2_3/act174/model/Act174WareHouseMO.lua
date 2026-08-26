-- chunkname: @modules/logic/versionactivity2_3/act174/model/Act174WareHouseMO.lua

module("modules.logic.versionactivity2_3.act174.model.Act174WareHouseMO", package.seeall)

local Act174WareHouseMO = pureTable("Act174WareHouseMO")

function Act174WareHouseMO:init(info)
	self.newHeroDic = {}
	self.newItemDic = {}
	self.heroId = info.heroId
	self.enhanceId = info.enhanceId

	self:caculateEnhanceRole(self.enhanceId)

	self.endEnhanceId = info.endEnhanceId
	self.itemId = info.itemId
end

function Act174WareHouseMO:update(info)
	for _, heroId in ipairs(info.heroId) do
		if not tabletool.indexOf(self.heroId, heroId) then
			self.newHeroDic[heroId] = 1
		end
	end

	local itemCntDic = Act174WareHouseMO.getItemCntDic(info.itemId)

	for _, itemId in ipairs(self.itemId) do
		if itemCntDic[itemId] then
			itemCntDic[itemId] = itemCntDic[itemId] - 1

			if itemCntDic[itemId] == 0 then
				itemCntDic[itemId] = nil
			end
		end
	end

	for id, cnt in pairs(itemCntDic) do
		local base = self.newItemDic[id]

		self.newItemDic[id] = base and base + cnt or cnt
	end

	self.heroId = info.heroId
	self.itemId = info.itemId
	self.enhanceId = info.enhanceId

	self:caculateEnhanceRole(self.enhanceId)

	self.endEnhanceId = info.endEnhanceId
end

function Act174WareHouseMO:getHeroData()
	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	local list = {}

	for k, id in ipairs(self.heroId) do
		local isEquip = gameInfo:isHeroInTeam(id)

		list[k] = {
			id = id,
			isEquip = isEquip
		}
	end

	table.sort(list, Act174WareHouseMO.SortRoleFunc)

	return list
end

function Act174WareHouseMO:getItemData()
	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	local list = {}
	local idCount = {}

	for k, id in ipairs(self.itemId) do
		idCount[id] = idCount[id] or gameInfo:getCollectionEquipCnt(id)

		local equipCnt = idCount[id]
		local isEquip = 0

		if equipCnt > 0 then
			isEquip = 1
			idCount[id] = equipCnt - 1
		end

		list[k] = {
			id = id,
			isEquip = isEquip
		}
	end

	table.sort(list, Act174WareHouseMO.SortItemFunc)

	return list
end

function Act174WareHouseMO.SortRoleFunc(a, b)
	if a.isEquip == b.isEquip then
		local coA = Activity174Config.instance:getRoleCo(a.id)
		local coB = Activity174Config.instance:getRoleCo(b.id)

		if coA.rare == coB.rare then
			return a.id > b.id
		else
			return coA.rare > coB.rare
		end
	else
		return a.isEquip > b.isEquip
	end
end

function Act174WareHouseMO.SortItemFunc(a, b)
	if a.isEquip == b.isEquip then
		local coA = Activity174Config.instance:getCollectionCo(a.id)
		local coB = Activity174Config.instance:getCollectionCo(b.id)

		if coA.rare == coB.rare then
			return a.id > b.id
		else
			return coA.rare > coB.rare
		end
	else
		return a.isEquip > b.isEquip
	end
end

function Act174WareHouseMO.getItemCntDic(itemIds)
	local itemCntList = {}

	for _, id in ipairs(itemIds) do
		itemCntList[id] = not itemCntList[id] and 1 or itemCntList[id] + 1
	end

	return itemCntList
end

function Act174WareHouseMO:getNewIdDic(wareType)
	if wareType == Activity174Enum.WareType.Hero then
		return tabletool.copy(self.newHeroDic)
	else
		return tabletool.copy(self.newItemDic)
	end
end

function Act174WareHouseMO:deleteNewSign(wareType, wareId)
	local newDic = wareType == Activity174Enum.WareType.Hero and self.newHeroDic or self.newItemDic

	if newDic[wareId] then
		newDic[wareId] = newDic[wareId] - 1

		if newDic[wareId] == 0 then
			newDic[wareId] = nil
		end
	end
end

function Act174WareHouseMO:clearNewSign()
	tabletool.clear(self.newHeroDic)
	tabletool.clear(self.newItemDic)
end

function Act174WareHouseMO:caculateEnhanceRole(enhanceList)
	self.enhanceRoleList = {}

	local effectList = {}

	for _, enhanceId in ipairs(enhanceList) do
		local enhanceCo = lua_activity174_enhance.configDict[enhanceId]

		if enhanceCo then
			if not string.nilorempty(enhanceCo.effects) then
				local effects = string.splitToNumber(enhanceCo.effects, "|")

				tabletool.addValues(effectList, effects)
			end
		else
			logError("dont exist enhanceCo" .. enhanceId)
		end
	end

	for _, effectId in ipairs(effectList) do
		local effectCo = lua_activity174_effect.configDict[effectId]

		if effectCo then
			if effectCo.type == Activity174Enum.EffectType.EnhanceRole then
				self.enhanceRoleList[#self.enhanceRoleList + 1] = tonumber(effectCo.typeParam)
			end
		else
			logError("dont exist enhanceCo" .. effectId)
		end
	end
end

return Act174WareHouseMO
