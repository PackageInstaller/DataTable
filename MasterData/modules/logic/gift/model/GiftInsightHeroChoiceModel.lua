-- chunkname: @modules/logic/gift/model/GiftInsightHeroChoiceModel.lua

module("modules.logic.gift.model.GiftInsightHeroChoiceModel", package.seeall)

local GiftInsightHeroChoiceModel = class("GiftInsightHeroChoiceModel", BaseModel)

function GiftInsightHeroChoiceModel:onInit()
	self._curHeroId = 0
end

function GiftInsightHeroChoiceModel:setCurHeroId(heroId)
	self._curHeroId = heroId
end

function GiftInsightHeroChoiceModel:getCurHeroId()
	return self._curHeroId
end

function GiftInsightHeroChoiceModel:getFitHeros(itemId)
	local couldUpHeros = {}
	local noUpHeros = {}
	local heros = HeroModel.instance:getAllHero()
	local itemCo = ItemConfig.instance:getInsightItemCo(itemId)

	for _, hero in pairs(heros) do
		local rares = string.splitToNumber(itemCo.heroRares, "#")

		for _, rare in pairs(rares) do
			if hero.config.rare + 1 == rare then
				if hero.rank < itemCo.heroRank + 1 then
					table.insert(couldUpHeros, hero)
				else
					table.insert(noUpHeros, hero)
				end
			end
		end
	end

	table.sort(couldUpHeros, GiftInsightHeroChoiceModel._sortFunc)
	table.sort(noUpHeros, GiftInsightHeroChoiceModel._sortFunc)

	return couldUpHeros, noUpHeros
end

function GiftInsightHeroChoiceModel._sortFunc(heroMOA, heroMOB)
	if heroMOA.config.rare ~= heroMOB.config.rare then
		return heroMOA.config.rare > heroMOB.config.rare
	elseif heroMOA.rank ~= heroMOB.rank then
		return heroMOA.rank > heroMOB.rank
	elseif heroMOA.level ~= heroMOB.level then
		return heroMOA.level > heroMOB.level
	else
		return heroMOA.heroId > heroMOB.heroId
	end
end

GiftInsightHeroChoiceModel.instance = GiftInsightHeroChoiceModel.New()

return GiftInsightHeroChoiceModel
