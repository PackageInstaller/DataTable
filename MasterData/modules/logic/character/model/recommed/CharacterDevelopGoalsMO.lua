-- chunkname: @modules/logic/character/model/recommed/CharacterDevelopGoalsMO.lua

module("modules.logic.character.model.recommed.CharacterDevelopGoalsMO", package.seeall)

local CharacterDevelopGoalsMO = pureTable("CharacterDevelopGoalsMO")

function CharacterDevelopGoalsMO:init(type, heroId)
	self._developGoalsType = type
	self._heroId = heroId
	self._isTraced = false
	self._heroMo = HeroModel.instance:getByHeroId(heroId)
end

function CharacterDevelopGoalsMO:setItemList(items)
	table.sort(items, self._sort)

	self._itemList = items
end

function CharacterDevelopGoalsMO._sort(a, b)
	local a_materilType = a.materilType
	local b_materilType = b.materilType

	if a_materilType ~= b_materilType then
		if a_materilType == MaterialEnum.MaterialType.Currency then
			return true
		end

		if b_materilType == MaterialEnum.MaterialType.Currency then
			return false
		end
	end

	local a_materilId = a.materilId
	local b_materilId = b.materilId

	if a_materilType == MaterialEnum.MaterialType.Currency then
		return a_materilId < b_materilId
	end

	local a_itemCo = ItemModel.instance:getItemConfig(a_materilType, a_materilId)
	local b_itemCo = ItemModel.instance:getItemConfig(b_materilType, b_materilId)
	local a_subType = a_itemCo.subType
	local b_subType = b_itemCo.subType
	local a_priority = lua_subclass_priority.configDict[a_subType].priority
	local b_priority = lua_subclass_priority.configDict[b_subType].priority

	if a_priority ~= b_priority then
		return a_priority < b_priority
	end

	local a_rare = a_itemCo.rare
	local b_rare = b_itemCo.rare

	if a_rare ~= b_rare then
		return b_rare < a_rare
	end

	return a_materilId < b_materilId
end

function CharacterDevelopGoalsMO:getItemList()
	return self._itemList
end

function CharacterDevelopGoalsMO:setTraced(isTraced)
	self._isTraced = isTraced
end

function CharacterDevelopGoalsMO:isTraced()
	return self._isTraced
end

function CharacterDevelopGoalsMO:getDevelopGoalsType()
	return self._developGoalsType
end

function CharacterDevelopGoalsMO:getTracedItems()
	if not self._itemList then
		return
	end

	local tracedItems = {}

	for _, item in ipairs(self._itemList) do
		local ownQuantity = ItemModel.instance:getItemQuantity(item.materilType, item.materilId)

		if ownQuantity < item.quantity then
			table.insert(tracedItems, item)
		end
	end

	return tracedItems
end

function CharacterDevelopGoalsMO:getHeroSkinCo()
	if not self._heroMo then
		return
	end

	return SkinConfig.instance:getSkinCo(self._heroMo.skin)
end

function CharacterDevelopGoalsMO:isCurRankMaxLv()
	if not self._heroMo then
		return
	end

	local curRankMaxLv = CharacterModel.instance:getrankEffects(self._heroId, self._heroMo.rank)[1]

	return curRankMaxLv <= self._heroMo.level, self._heroMo
end

function CharacterDevelopGoalsMO:isMaxTalentLv()
	if not self._heroMo then
		return
	end

	local maxLv = CharacterModel.instance:getMaxTalent(self._heroId)

	return maxLv <= self._heroMo.talent, self._heroMo
end

function CharacterDevelopGoalsMO:isOwnHero()
	return self._heroMo and self._heroMo:isOwnHero()
end

function CharacterDevelopGoalsMO:setTitleTxtAndIcon(txt, icon)
	self._titleTxt = txt
	self._titleIcon = icon
end

function CharacterDevelopGoalsMO:getTitleTxtAndIcon()
	return self._titleTxt, self._titleIcon
end

return CharacterDevelopGoalsMO
