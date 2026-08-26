-- chunkname: @modules/logic/backpack/model/ItemModel.lua

module("modules.logic.backpack.model.ItemModel", package.seeall)

local ItemModel = class("ItemModel", BaseModel)

function ItemModel:onInit()
	self._itemList = {}
	self._localQuantityChanged = {}
end

function ItemModel:reInit()
	self._itemList = {}
	self._localQuantityChanged = {}
end

function ItemModel:convertMaterialData(materialData)
	if not materialData then
		return nil
	end

	if self:materialIsItem(materialData) then
		local itemMo = ItemMo.New()

		itemMo:initFromMaterialData(materialData)

		return itemMo
	end
end

function ItemModel:materialIsItem(materialData)
	if not materialData then
		return false
	end

	if materialData.materilType == MaterialEnum.MaterialType.Item then
		return true
	end

	if materialData.materilType == MaterialEnum.MaterialType.PowerPotion then
		return true
	end

	if materialData.materilType == MaterialEnum.MaterialType.NewInsight then
		return true
	end

	return false
end

local quantityGetFunc = {
	[MaterialEnum.MaterialType.Item] = function(id)
		return ItemModel.instance:getItemCount(id)
	end,
	[MaterialEnum.MaterialType.Exp] = function(id)
		return 1
	end,
	[MaterialEnum.MaterialType.Bp] = function(id)
		if BpModel.instance:isEnd() then
			return 0
		end

		local levelScore = BpConfig.instance:getLevelScore(BpModel.instance.id)

		return BpModel.instance.score % levelScore
	end,
	[MaterialEnum.MaterialType.ActBp] = function(id)
		local actId = Anniversary3ActBpModel.instancde:getCurActId()
		local bpId = Activity233Config.instance:getCurBpId()
		local score = Anniversary3ActBpModel.instance:getActBpScore(bpId, actId)
		local levelScore = Activity233Config.instance:getLevelScore(bpId)

		return score % levelScore
	end,
	[MaterialEnum.MaterialType.HeroSkin] = function(id)
		if HeroModel.instance:checkHasSkin(id) then
			return 1
		end

		local skinConfig = SkinConfig.instance:getSkinCo(id)
		local characterId = skinConfig and skinConfig.characterId
		local heroMO = HeroModel.instance:getByHeroId(characterId)
		local skinInfoList = heroMO and heroMO.skinInfoList

		if skinInfoList and #skinInfoList > 0 then
			for i, skinInfo in ipairs(skinInfoList) do
				if skinInfo.skin == id then
					return 1
				end
			end
		end

		return 0
	end,
	[MaterialEnum.MaterialType.Hero] = function(id)
		local heroMO = HeroModel.instance:getByHeroId(id)

		return heroMO and 1 or 0
	end,
	[MaterialEnum.MaterialType.Currency] = function(id)
		local currency = CurrencyModel.instance:getCurrency(id)

		if not currency then
			logError("获取不到货币数量, CurrencyId: " .. tostring(id))

			return 0
		else
			return currency.quantity
		end
	end,
	[MaterialEnum.MaterialType.PowerPotion] = function(id, uid)
		if uid then
			return ItemPowerModel.instance:getPowerItemCount(uid)
		end

		local config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.PowerPotion, id)

		if not config then
			return 0
		end

		local count = 0
		local effect = config.effect
		local powerPotionConfigList = lua_power_item.configList

		for i, powerPotionConfig in ipairs(powerPotionConfigList) do
			if effect == powerPotionConfig.effect then
				count = count + ItemPowerModel.instance:getPowerItemCountById(powerPotionConfig.id)
			end
		end

		return count
	end,
	[MaterialEnum.MaterialType.Equip] = function(id)
		return EquipModel.instance:getEquipQuantity(id)
	end,
	[MaterialEnum.MaterialType.PlayerCloth] = function(id)
		local unlock = PlayerClothModel.instance:hasCloth(id)

		return unlock and 1 or 0
	end,
	[MaterialEnum.MaterialType.Building] = function(id)
		return RoomModel.instance:getBuildingCount(id)
	end,
	[MaterialEnum.MaterialType.Formula] = function(id)
		return RoomModel.instance:getFormulaCount(id)
	end,
	[MaterialEnum.MaterialType.BlockPackage] = function(id)
		return RoomModel.instance:isHasBlockPackageById(id) and 1 or 0
	end,
	[MaterialEnum.MaterialType.SpecialBlock] = function(id)
		return RoomModel.instance:isHasBlockById(id) and 1 or 0
	end,
	[MaterialEnum.MaterialType.RoomTheme] = function(id)
		return RoomModel.instance:isHasRoomThemeById(id) and 1 or 0
	end,
	[MaterialEnum.MaterialType.Explore] = function(id)
		local mo = ExploreBackpackModel.instance:getItem(id)

		return (mo or nil) and (mo.quantity or 0)
	end,
	[MaterialEnum.MaterialType.EquipCard] = function(id)
		return SeasonEquipMetaUtils.getCurSeasonEquipCount(id)
	end,
	[MaterialEnum.MaterialType.Antique] = function(id)
		return AntiqueModel.instance:getAntique(id) and 1 or 0
	end,
	[MaterialEnum.MaterialType.UnlockVoucher] = function(id)
		return UnlockVoucherModel.instance:getVoucher(id) and 1 or 0
	end,
	[MaterialEnum.MaterialType.V1a5AiZiLa] = function(id)
		return AiZiLaModel.instance:getItemQuantity(id)
	end,
	[MaterialEnum.MaterialType.Season123EquipCard] = function(id)
		return Season123EquipMetaUtils.getCurSeasonEquipCount(id)
	end,
	[MaterialEnum.MaterialType.NewInsight] = function(id, uid)
		if uid then
			return ItemInsightModel.instance:getInsightItemCount(uid)
		end

		local config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.NewInsight, id)

		if not config then
			return 0
		end

		local count = 0
		local insightConfigList = lua_insight_item.configList

		for _, insightCo in ipairs(insightConfigList) do
			if insightCo.id == id then
				count = count + ItemInsightModel.instance:getInsightItemCountById(insightCo.id)
			end
		end

		return count
	end,
	[MaterialEnum.MaterialType.Critter] = function(id)
		return CritterModel.instance:getCritterCntById(id)
	end,
	[MaterialEnum.MaterialType.TalentItem] = function(id, uid)
		if uid then
			return ItemTalentModel.instance:getTalentItemCount(uid)
		end

		local config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.TalentItem, id)

		if not config then
			return 0
		end

		local count = 0
		local talentConfigList = lua_talent_upgrade_item.configList

		for i, talentCo in ipairs(talentConfigList) do
			if id == talentCo.id then
				count = count + ItemTalentModel.instance:getTalentItemCountById(talentCo.id)
			end
		end

		return count
	end,
	[MaterialEnum.MaterialType.SpecialExpiredItem] = function(id, uid)
		if uid then
			return ItemExpireModel.instance:getExpireItemCount(uid)
		end

		local config = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.SpecialExpiredItem, id)

		if not config then
			return 0
		end

		local count = 0
		local configList = lua_specialexpired_item.configList

		for _, co in ipairs(configList) do
			if co.id == id then
				count = count + ItemExpireModel.instance:getExpireItemCountById(co.id)
			end
		end

		return count
	end
}

function ItemModel:getItemConfig(type, id)
	return ItemConfig.instance:getItemConfig(type, id)
end

function ItemModel:getItemConfigAndIcon(type, id, isIcon)
	type = tonumber(type)
	id = tonumber(id)

	local config = self:getItemConfig(type, id)

	if not config then
		logError(string.format("getItemConfigAndIcon no config type:%s,id:%s", type, id))

		return
	end

	local icon, itemIcon
	local getFunc = ItemIconGetDefine.instance:getItemIconFunc(type)

	if getFunc then
		icon, itemIcon = getFunc(config)

		if not string.nilorempty(itemIcon) and isIcon then
			icon = itemIcon
		end
	else
		icon = ResUrl.getSpecialPropItemIcon(config.icon)
	end

	return config, icon
end

function ItemModel:getItemSmallIcon(id)
	local config = self:getItemConfig(MaterialEnum.MaterialType.Item, id)

	return config and ResUrl.getPropItemIconSmall(config.icon)
end

function ItemModel:getItemQuantity(type, id, uid, fakeQuantity)
	type = tonumber(type)
	id = tonumber(id)

	local quantity
	local getFunc = quantityGetFunc[type]

	if getFunc then
		quantity = getFunc(id, uid)
	else
		logError("获取道具数量失败")

		quantity = 0
	end

	if fakeQuantity then
		local localQuantityChanged = self:getLocalQuantityChanged(type, id, uid)

		quantity = quantity + localQuantityChanged
	end

	return quantity
end

function ItemModel:setLocalQuantityChanged(key, items)
	self._localQuantityChanged[key] = items
end

function ItemModel:hasLocalQuantityChanged(key)
	return self._localQuantityChanged[key]
end

function ItemModel:getLocalQuantityChanged(type, id, uid)
	local localQuantityChanged = 0

	for key, items in pairs(self._localQuantityChanged) do
		for i, item in ipairs(items) do
			if item.type == type and item.id == id and item.uid == uid then
				localQuantityChanged = localQuantityChanged + item.quantity
			end
		end
	end

	return localQuantityChanged
end

function ItemModel:getItemRare(config)
	return (config or nil) and (config.rare or 1)
end

function ItemModel:setItemList(serco)
	self._itemList = {}

	for _, v in ipairs(serco) do
		local itemMo = ItemMo.New()

		itemMo:init(v)
		table.insert(self._itemList, itemMo)
	end

	self:setList(self._itemList)
end

function ItemModel:changeItemList(co)
	self._itemList = self:getList()

	for _, v in ipairs(co) do
		local mo = self:getById(v.itemId)

		if not mo then
			local itemMo = ItemMo.New()

			itemMo:init(v)

			itemMo.quantity = v.quantity

			table.insert(self._itemList, itemMo)
		elseif v.quantity == 0 then
			self:remove(mo)
		else
			mo.quantity = v.quantity
		end
	end

	self:setList(self._itemList)
end

function ItemModel:getItemCount(id)
	local mo = self:getById(id)

	return (mo or nil) and (mo.quantity or 0)
end

function ItemModel:getItemList()
	return self._itemList
end

function ItemModel:getItemsBySubType(subType)
	local items = {}

	for _, v in pairs(self._itemList) do
		local config = lua_item.configDict[v.id]

		if config and config.subType == subType then
			table.insert(items, v)
		end
	end

	return items
end

function ItemModel:hasEnoughItems(items)
	local mergedItemDict = {}

	for i = 1, #items do
		local item = items[i]

		mergedItemDict[item.type] = mergedItemDict[item.type] or {}
		mergedItemDict[item.type][item.id] = (mergedItemDict[item.type][item.id] or 0) + item.quantity
	end

	for i = 1, #items do
		local item = items[i]
		local hasQuantity = self:getItemQuantity(item.type, item.id)

		if hasQuantity < mergedItemDict[item.type][item.id] then
			local itemCo, icon = self:getItemConfigAndIcon(item.type, item.id)

			return (itemCo or nil) and itemCo.name, false, icon
		end
	end

	return "", true
end

function ItemModel:getItemDataListByConfigStr(str, stackable, force_stackable)
	local arr = GameUtil.splitString2(str, true)
	local temp_list = {}
	local item_data

	if arr and #arr > 0 then
		for index, item in ipairs(arr) do
			local materilType = item[1]
			local materilId = item[2]
			local quantity = item[3]

			if stackable then
				item_data = item_data or {}

				if not force_stackable and not ItemConfig.instance:isItemStackable(materilType, materilId) then
					for j = 1, quantity do
						table.insert(temp_list, {
							quantity = 1,
							isIcon = true,
							materilType = materilType,
							materilId = materilId
						})
					end
				else
					item_data[materilType] = item_data[materilType] or {}
					item_data[materilType][materilId] = item_data[materilType][materilId] or {}
					item_data[materilType][materilId].materilType = materilType
					item_data[materilType][materilId].materilId = materilId
					item_data[materilType][materilId].quantity = quantity
					item_data[materilType][materilId].isIcon = true
				end
			else
				table.insert(temp_list, {
					isIcon = true,
					materilType = materilType,
					materilId = materilId,
					quantity = quantity
				})
			end
		end
	end

	if stackable and item_data then
		for k, v in pairs(item_data) do
			for index, value in pairs(v) do
				table.insert(temp_list, value)
			end
		end
	end

	return temp_list
end

function ItemModel:goodsIsEnough(materilType, materilId, cost_num)
	local own_num = self:getItemQuantity(materilType, materilId)

	return cost_num <= own_num, own_num
end

function ItemModel:getItemIsEnoughText(goods_data)
	local quantity = ItemModel.instance:getItemQuantity(goods_data.materilType, goods_data.materilId)

	if quantity >= goods_data.quantity then
		if goods_data.materilType == MaterialEnum.MaterialType.Currency then
			return tostring(GameUtil.numberDisplay(goods_data.quantity))
		else
			return tostring(GameUtil.numberDisplay(quantity)) .. "/" .. tostring(GameUtil.numberDisplay(goods_data.quantity))
		end
	else
		local lackedQuantity = goods_data.quantity - quantity

		if goods_data.materilType == MaterialEnum.MaterialType.Currency then
			return "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(goods_data.quantity)) .. "</color>", lackedQuantity
		else
			return "<color=#cd5353>" .. tostring(GameUtil.numberDisplay(quantity)) .. "</color>" .. "/" .. tostring(GameUtil.numberDisplay(goods_data.quantity)), lackedQuantity
		end
	end
end

function ItemModel:hasEnoughItemsByCellData(items)
	local mergedItemDict = {}

	for i = 1, #items do
		local item = items[i]

		mergedItemDict[item.materilType] = mergedItemDict[item.materilType] or {}
		mergedItemDict[item.materilType][item.materilId] = (mergedItemDict[item.materilType][item.materilId] or 0) + item.quantity
	end

	for i = 1, #items do
		local item = items[i]
		local hasQuantity = self:getItemQuantity(item.materilType, item.materilId)

		if hasQuantity < mergedItemDict[item.materilType][item.materilId] then
			local itemCo, icon = self:getItemConfigAndIcon(item.materilType, item.materilId)

			return (itemCo or nil) and itemCo.name, false, icon
		end
	end

	return "", true
end

function ItemModel:processRPCItemList(list)
	if not list then
		return {}
	end

	local newList = {}

	for k, item in ipairs(list) do
		if ItemConfig.instance:isItemStackable(item.materilType, item.materilId) then
			table.insert(newList, item)
		else
			for i = 1, item.quantity do
				local sItem = {
					quantity = 1,
					bonusTag = item.bonusTag,
					materilType = item.materilType,
					materilId = item.materilId,
					uid = item.uid
				}

				table.insert(newList, sItem)
			end
		end
	end

	return newList
end

function ItemModel.canShowVfx(materialType, itemConfig, rare)
	materialType = tonumber(materialType)

	if materialType == MaterialEnum.MaterialType.PlayerCloth then
		rare = rare or 5
	end

	local categoryCfg = ItemConfig.instance:getItemCategroyShow(materialType)

	if categoryCfg and categoryCfg.highQuality == 1 then
		if itemConfig.highQuality ~= nil then
			if rare ~= nil then
				return rare >= 4 and itemConfig.highQuality == 1
			else
				return itemConfig.highQuality == 1
			end
		elseif rare ~= nil then
			return rare >= 5
		else
			return true
		end
	else
		return false
	end
end

function ItemModel:setOptionalGift()
	self.optionalGiftData = {}

	local subTypeList = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.OptionalGift)

	if subTypeList then
		for _, co in pairs(subTypeList) do
			if not string.nilorempty(co.effect) then
				local data = {}
				local effect = string.split(co.effect, "|")
				local effect1 = string.splitToNumber(effect[1], "#")

				data.subType = effect1[1]
				data.rare = effect1[2] or co.rare
				data.ignore = string.splitToNumber(effect[2], "#")
				data.co = co
				data.id = co.id
				data.materials = {}

				local materialSubTypeList = ItemConfig.instance:getItemListBySubType(data.subType)

				if materialSubTypeList then
					for _, materialsCo in pairs(materialSubTypeList) do
						if materialsCo.rare == data.rare and not LuaUtil.tableContains(data.ignore, materialsCo.id) then
							table.insert(data.materials, materialsCo.id)
						end
					end

					self.optionalGiftData[co.id] = data
				end
			end
		end
	end
end

function ItemModel:getOptionalGiftMaterialSubTypeList(id)
	if self.optionalGiftData then
		return self.optionalGiftData and self.optionalGiftData.materials
	end
end

function ItemModel:getOptionalGiftBySubTypeAndRare(subType, rare, id)
	local giftDataList = {}

	if self.optionalGiftData then
		for _, _data in pairs(self.optionalGiftData) do
			if _data.subType == subType and _data.rare == rare and LuaUtil.tableContains(_data.materials, id) then
				table.insert(giftDataList, _data)
			end
		end
	end

	return giftDataList
end

ItemModel.instance = ItemModel.New()

return ItemModel
