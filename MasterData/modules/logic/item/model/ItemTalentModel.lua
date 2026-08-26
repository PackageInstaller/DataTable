-- chunkname: @modules/logic/item/model/ItemTalentModel.lua

module("modules.logic.item.model.ItemTalentModel", package.seeall)

local ItemTalentModel = class("ItemTalentModel", BaseModel)

function ItemTalentModel:onInit()
	self:reInit()
end

function ItemTalentModel:reInit()
	self._talentItemList = {}
end

function ItemTalentModel:getTalentItem(uid)
	return self._talentItemList[tonumber(uid)]
end

function ItemTalentModel:getTalentItemList()
	return self._talentItemList
end

function ItemTalentModel:setTalentItemList(talentList)
	self._talentItemList = {}

	for _, v in ipairs(talentList) do
		local itemMo = ItemTalentMO.New()

		itemMo:init(v)

		self._talentItemList[tonumber(v.uid)] = itemMo
	end
end

function ItemTalentModel:changeTalentItemList(talentList)
	for _, v in ipairs(talentList) do
		if not self._talentItemList[tonumber(v.uid)] then
			local itemMo = ItemTalentMO.New()

			itemMo:init(v)

			self._talentItemList[tonumber(v.uid)] = itemMo
		else
			self._talentItemList[tonumber(v.uid)]:reset(v)
		end
	end
end

function ItemTalentModel:getTalentItemCount(uid)
	return self._talentItemList[tonumber(uid)] and self._talentItemList[tonumber(uid)].quantity or 0
end

function ItemTalentModel:getTalentItemCountById(id)
	local count = 0

	for _, itemMO in pairs(self._talentItemList) do
		if itemMO.talentItemId == id then
			count = count + itemMO.quantity
		end
	end

	return count
end

function ItemTalentModel:getTalentItemDeadline(uid)
	local item = self._talentItemList[tonumber(uid)]

	return item and tonumber(item.expireTime) or 0
end

function ItemTalentModel:getTalentItemByItemId(id)
	for _, itemMO in pairs(self._talentItemList) do
		if itemMO.talentItemId == id then
			return itemMO
		end
	end

	return nil
end

function ItemTalentModel:setCurSelectHero(heroId)
	self._curHeroId = heroId
end

function ItemTalentModel:getCurSelectHero()
	return self._curHeroId
end

function ItemTalentModel:getCouldUpgradeTalentHeroList(itemId)
	local itemCo = ItemTalentConfig.instance:getTalentItemCo(itemId)
	local filters = string.splitToNumber(itemCo.effect, "#")
	local maxTalent = filters[2]
	local rare = filters[3]
	local list = {}
	local heroList = HeroModel.instance:getAllHero()

	for _, heroMo in pairs(heroList) do
		if heroMo.config.rare == rare and maxTalent > heroMo.talent then
			local nextCo = HeroResonanceConfig.instance:getTalentConfig(heroMo.heroId, heroMo.talent + 1)

			if heroMo.rank >= nextCo.requirement then
				table.insert(list, heroMo)
			end
		end
	end

	return list
end

ItemTalentModel.instance = ItemTalentModel.New()

return ItemTalentModel
