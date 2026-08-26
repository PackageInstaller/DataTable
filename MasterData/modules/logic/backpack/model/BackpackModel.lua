-- chunkname: @modules/logic/backpack/model/BackpackModel.lua

module("modules.logic.backpack.model.BackpackModel", package.seeall)

local BackpackModel = class("BackpackModel", BaseModel)

function BackpackModel:onInit()
	self:reInit()
end

function BackpackModel:reInit()
	self._curCategoryId = 1
	self._categoryList = {}
	self._itemList = {}
	self._itemAniHasShown = false
end

function BackpackModel:getItemAniHasShown()
	return self._itemAniHasShown
end

function BackpackModel:setItemAniHasShown(show)
	self._itemAniHasShown = show
end

function BackpackModel:getCurCategoryId()
	return self._curCategoryId
end

function BackpackModel:setCurCategoryId(id)
	self._curCategoryId = id
end

function BackpackModel:setBackpackCategoryList(cates)
	self._categoryList = cates
end

function BackpackModel:setBackpackItemList(list, adventure)
	self._itemList = {}

	for _, v in pairs(list) do
		local item, type
		local convert = true

		if v.uid then
			if v.insightId then
				type = MaterialEnum.MaterialType.NewInsight

				local insightItem = ItemInsightModel.instance:getInsightItem(v.uid)

				convert = insightItem and insightItem.quantity > 0

				if convert then
					item = self:_convertItemData(v.uid, type)
				end
			elseif v.talentItemId then
				type = MaterialEnum.MaterialType.TalentItem

				local talentItem = ItemTalentModel.instance:getTalentItem(v.uid)

				convert = talentItem and talentItem.quantity > 0

				if convert then
					item = self:_convertItemData(v.uid, type)
				end
			else
				type = MaterialEnum.MaterialType.PowerPotion

				local powerItem = ItemPowerModel.instance:getPowerItem(v.uid)

				convert = powerItem and powerItem.quantity > 0

				if convert then
					item = self:_convertItemData(v.uid, type)
				end
			end
		elseif v.id then
			type = MaterialEnum.MaterialType.Item
			convert = adventure and v.quantity > 0 or ItemModel.instance:getItemCount(v.id) > 0

			if convert then
				item = self:_convertItemData(v.id, type, adventure and v.quantity)
			end
		elseif v.currencyId then
			type = MaterialEnum.MaterialType.Currency
			item = self:_convertItemData(v.currencyId, MaterialEnum.MaterialType.Currency)
		end

		if convert and item then
			local backMo = BackpackMo.New()

			backMo:init(item)
			table.insert(self._itemList, backMo)
		end
	end

	self:setPowerMakerItemsList()
end

function BackpackModel:setPowerMakerItemsList()
	local ofMakerInfo = ItemPowerModel.instance:getPowerMakerInfo()

	if ofMakerInfo and ofMakerInfo.powerMakerItems then
		self._powerMakerItems = self._powerMakerItems or {}

		local itemList = {}

		for k, v in pairs(self._itemList) do
			if v.id ~= MaterialEnum.PowerId.OverflowPowerId then
				table.insert(itemList, v)
			end
		end

		for i = 1, #ofMakerInfo.powerMakerItems do
			local v = ofMakerInfo.powerMakerItems[i]
			local type = MaterialEnum.MaterialType.PowerPotion
			local uid = tonumber(v.uid)
			local item = self:_convertItemData(uid, type)

			if not self._powerMakerItems[uid] then
				local itemMo = BackpackMo.New()

				self._powerMakerItems[uid]:init(item)
				table.insert(itemList, self._powerMakerItems[uid])
			end
		end

		self._itemList = itemList
	end
end

function BackpackModel:getBackpackItemList()
	return self._itemList
end

function BackpackModel:getBackpackList()
	local list = {}

	for _, v in pairs(ItemModel.instance:getList()) do
		table.insert(list, v)
	end

	for _, v in pairs(CurrencyModel.instance:getCurrencyList()) do
		if v.quantity > 0 then
			table.insert(list, v)
		end
	end

	for _, v in pairs(ItemPowerModel.instance:getPowerItemList()) do
		if v.quantity > 0 then
			table.insert(list, v)
		end
	end

	for _, v in pairs(ItemInsightModel.instance:getInsightItemList()) do
		if v.quantity > 0 then
			table.insert(list, v)
		end
	end

	for _, v in pairs(ItemTalentModel.instance:getTalentItemList()) do
		if v.quantity > 0 then
			table.insert(list, v)
		end
	end

	return list
end

function BackpackModel:_convertItemData(id, type, quantity)
	local data = {}

	data.type = type

	local config, icon

	if data.type == MaterialEnum.MaterialType.PowerPotion then
		data.uid = id
		data.id = ItemPowerModel.instance:getPowerItem(id).id
		config, icon = ItemModel.instance:getItemConfigAndIcon(data.type, data.id)
	elseif data.type == MaterialEnum.MaterialType.TalentItem then
		data.uid = id
		data.id = ItemTalentModel.instance:getTalentItem(id).talentItemId
		config, icon = ItemModel.instance:getItemConfigAndIcon(data.type, data.id)
	elseif data.type == MaterialEnum.MaterialType.NewInsight then
		data.uid = id
		data.id = ItemInsightModel.instance:getInsightItem(id).insightId
		config, icon = ItemModel.instance:getItemConfigAndIcon(data.type, data.id)
	else
		data.id = id
		config, icon = ItemModel.instance:getItemConfigAndIcon(data.type, id)
	end

	if not config then
		logError(string.format("convertItemData no config, type: %s, id: %s", type, id))

		return nil
	end

	data.quantity = quantity or ItemModel.instance:getItemQuantity(data.type, data.id, data.uid)
	data.icon = icon
	data.rare = config.rare

	if data.type == MaterialEnum.MaterialType.Item then
		data.isStackable = config.isStackable
		data.isShow = config.isShow
		data.subType = config.subType
		data.isTimeShow = config.isTimeShow
		data.expireTime = config.expireTime or -1
	elseif data.type == MaterialEnum.MaterialType.PowerPotion then
		data.isStackable = 1
		data.isShow = 1
		data.subType = 0
		data.isTimeShow = config.expireType == 0 and 0 or 1
		data.expireTime = config.expireType == 0 and -1 or ItemPowerModel.instance:getPowerItemDeadline(id)
	elseif data.type == MaterialEnum.MaterialType.TalentItem then
		data.isStackable = 1
		data.isShow = 1
		data.subType = 0
		data.isTimeShow = config.expireType == 0 and 0 or 1
		data.expireTime = config.expireType == 0 and -1 or ItemTalentModel.instance:getTalentItemDeadline(id)
	elseif data.type == MaterialEnum.MaterialType.NewInsight then
		data.isStackable = 1
		data.isShow = 1
		data.subType = 0
		data.expireTime = ItemInsightModel.instance:getInsightItemDeadline(id)

		local config = ItemConfig.instance:getInsightItemCo(data.id)
		local isTimeShow = config and config.expireType ~= 0 and config.expireHours ~= ItemEnum.NoExpiredNum

		data.isTimeShow = isTimeShow and 1 or 0
	elseif data.type == MaterialEnum.MaterialType.Currency then
		data.isStackable = 1
		data.isShow = 1
		data.subType = 0
		data.isTimeShow = 0
	end

	return data
end

function BackpackModel:getCategoryItemlist(id)
	local items = {}

	for _, v in pairs(self._itemList) do
		local belongs = self:_getItemBelong(v.type, v.id)

		if v.type == MaterialEnum.MaterialType.PowerPotion then
			if id == ItemEnum.CategoryType.All or id == ItemEnum.CategoryType.UseType then
				table.insert(items, v)
			end
		elseif v.type == MaterialEnum.MaterialType.TalentItem then
			if id == ItemEnum.CategoryType.All or id == ItemEnum.CategoryType.UseType then
				table.insert(items, v)
			end
		elseif v.type == MaterialEnum.MaterialType.NewInsight then
			if id == ItemEnum.CategoryType.All or id == ItemEnum.CategoryType.UseType then
				table.insert(items, v)
			end
		else
			for _, belong in pairs(belongs) do
				if belong == id then
					table.insert(items, v)
				end
			end
		end
	end

	return items
end

function BackpackModel:_getItemBelong(type, id)
	type = tonumber(type)
	id = tonumber(id)

	local belongs = {}

	table.insert(belongs, ItemEnum.CategoryType.All)

	for _, v in pairs(self._categoryList) do
		local includes, tag

		if type == MaterialEnum.MaterialType.Item then
			includes = v.includeitem
			tag = ItemConfig.instance:getItemCo(id).subType
		elseif type == MaterialEnum.MaterialType.Currency then
			includes = v.includecurrency
			tag = id
		end

		if self:_isItemBelongCate(includes, tag) and not LuaUtil.tableContains(belongs, tonumber(v.id)) then
			table.insert(belongs, tonumber(v.id))
		end
	end

	return belongs
end

function BackpackModel:_isItemBelongCate(include, tag)
	local includes = string.split(include, "#")

	if not includes then
		return false
	end

	for _, v in pairs(includes) do
		if tonumber(v) == tag then
			return true
		end
	end

	return false
end

function BackpackModel:getCategoryItemsDeadline(id)
	local items = self:getCategoryItemlist(id)
	local expireTime = -1

	for _, v in pairs(items) do
		if v.isShow == 1 and v.isTimeShow == 1 then
			local time = v:itemExpireTime()

			expireTime = time ~= -1 and (expireTime == -1 and time or time < expireTime and time) or expireTime
		end
	end

	return expireTime
end

function BackpackModel:getItemDeadline()
	local itemlist = ItemModel.instance:getItemList() or {}
	local deadline

	for _, v in pairs(itemlist) do
		local config = ItemConfig.instance:getItemCo(v.id)

		if config then
			if config.isShow == 1 and config.expireTime and config.expireTime ~= "" then
				local time = config.expireTime

				if type(time) == "string" then
					time = TimeUtil.stringToTimestamp(time)
				end

				if not deadline or time < deadline then
					deadline = time
				end
			end
		else
			logError("找不到道具配置, id: " .. v.id)
		end
	end

	local powitemlist = ItemPowerModel.instance:getPowerItemList() or {}

	for k, v in pairs(powitemlist) do
		local config = ItemConfig.instance:getPowerItemCo(v.id)

		if config.expireType ~= 0 and ItemPowerModel.instance:getPowerItemCount(v.uid) > 0 then
			local time = ItemPowerModel.instance:getPowerItemDeadline(v.uid)

			if not deadline or time < deadline then
				deadline = time
			end
		end
	end

	local talentItemlist = ItemTalentModel.instance:getTalentItemList() or {}

	for k, v in pairs(talentItemlist) do
		local config = ItemTalentConfig.instance:getTalentItemCo(v.id)

		if ItemTalentModel.instance:getTalentItemCount(v.uid) > 0 then
			local time = ItemTalentModel.instance:getTalentItemDeadline(v.uid)

			if not deadline or time < deadline then
				deadline = time
			end
		end
	end

	local insightitemlist = ItemInsightModel.instance:getInsightItemList() or {}

	for _, v in pairs(insightitemlist) do
		local config = ItemConfig.instance:getInsightItemCo(v.insightId)

		if config.expireType ~= 0 and config.expireHours ~= ItemEnum.NoExpiredNum and ItemInsightModel.instance:getInsightItemCount(v.uid) > 0 then
			local time = ItemInsightModel.instance:getInsightItemDeadline(v.uid)

			if not deadline or time < deadline then
				deadline = time
			end
		end
	end

	return deadline
end

BackpackModel.instance = BackpackModel.New()

return BackpackModel
