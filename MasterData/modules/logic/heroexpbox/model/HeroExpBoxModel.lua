-- chunkname: @modules/logic/heroexpbox/model/HeroExpBoxModel.lua

module("modules.logic.heroexpbox.model.HeroExpBoxModel", package.seeall)

local HeroExpBoxModel = class("HeroExpBoxModel", BaseModel)
local MaterialType = MaterialEnum.MaterialType.Item

function HeroExpBoxModel:onInit()
	self:reInit()
end

function HeroExpBoxModel:reInit()
	self._boxEffectList = {}
	self._selectHeroId = nil
end

function HeroExpBoxModel:_initBox(itemId)
	self._boxEffectList = self._boxEffectList or {}
	self._boxEffectList[itemId] = {}

	local co = ItemModel.instance:getItemConfig(MaterialType, itemId)

	if not co then
		return
	end

	local item = {}

	item.co = co

	local effect = co.effect

	if string.nilorempty(effect) then
		return
	end

	local split = string.split(effect, "|")

	if split[1] then
		item.needKeyCount = tonumber(split[1])
	end

	if split[2] then
		item.overflowCurrency = string.splitToNumber(split[2], "#")
	end

	if split[3] then
		item.heroMoList = {}

		local heroIdList = string.splitToNumber(split[3], "#")

		for _, hero in ipairs(heroIdList) do
			local mo = HeroExpBoxMO.New(hero)

			table.insert(item.heroMoList, mo)
		end
	end

	self._boxEffectList[itemId] = item
end

function HeroExpBoxModel:getBoxEffect(itemId)
	self._boxEffectList = self._boxEffectList or {}

	if not self._boxEffectList[itemId] then
		self:_initBox(itemId)
	end

	return self._boxEffectList[itemId]
end

function HeroExpBoxModel:getBoxEffectIncludeItems(itemId)
	local heroList = self:getBoxHeroMoList(itemId)
	local itemList = {}

	for _, heroMo in ipairs(heroList) do
		local heroCo = HeroConfig.instance:getHeroCO(heroMo.heroId)
		local duplicateItem = GameUtil.splitString2(heroCo.duplicateItem, true, "|", "#")
		local item = duplicateItem[1]

		table.insert(itemList, item)
	end

	return itemList
end

function HeroExpBoxModel:getBoxHeroMoList(itemId)
	local effect = self:getBoxEffect(itemId)

	return (effect or nil) and (effect.heroMoList or {})
end

function HeroExpBoxModel:setSelectHeroId(heroId)
	self._selectHeroId = heroId
end

function HeroExpBoxModel:getSelectHeroId()
	return self._selectHeroId
end

function HeroExpBoxModel:getBoxCount()
	local quantity = 0
	local configs = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.HeroExpBox)

	for _, co in ipairs(configs) do
		quantity = quantity + ItemModel.instance:getItemQuantity(MaterialType, co.id)
	end

	return quantity
end

function HeroExpBoxModel:getBoxId()
	local configs = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.HeroExpBox)
	local var_10_0

	if configs then
		::label_10_0::

		var_10_0 = configs[1] and configs[1].id
	end

	return var_10_0
end

function HeroExpBoxModel:getKeyCo()
	return (ItemModel.instance:getItemConfig(MaterialType, self:getKeyId()))
end

function HeroExpBoxModel:getKeyIcon()
	local co = self:getKeyCo()

	return co.icon
end

function HeroExpBoxModel:getKeyName()
	local co = self:getKeyCo()

	return co.name
end

function HeroExpBoxModel:getKeyCount()
	local quantity = 0
	local configs = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.HeroExpBoxKey)

	for _, co in ipairs(configs) do
		quantity = quantity + ItemModel.instance:getItemQuantity(MaterialType, co.id)
	end

	return quantity
end

function HeroExpBoxModel:getKeyId()
	local configs = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.HeroExpBoxKey)
	local var_15_0

	if configs then
		::label_15_0::

		var_15_0 = configs[1] and configs[1].id
	end

	return var_15_0
end

function HeroExpBoxModel:getNeedKeyCount(itemId)
	local effect = self:getBoxEffect(itemId)

	return effect.needKeyCount
end

function HeroExpBoxModel:hasExpBoxItem()
	for _, type in ipairs(HeroExpBoxEnum.ItemSubType) do
		local list = ItemModel.instance:getItemsBySubType(type)

		if #list > 0 then
			return true
		end
	end
end

HeroExpBoxModel.instance = HeroExpBoxModel.New()

return HeroExpBoxModel
