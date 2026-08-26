-- chunkname: @modules/logic/summon/model/SummonLuckyBagChoiceListModel.lua

module("modules.logic.summon.model.SummonLuckyBagChoiceListModel", package.seeall)

local SummonLuckyBagChoiceListModel = class("SummonLuckyBagChoiceListModel", ListScrollModel)

function SummonLuckyBagChoiceListModel:onInit()
	self:clear()
end

function SummonLuckyBagChoiceListModel:reInit()
	self:clear()
end

local function sortFunc(a, b)
	local aHeroMo = HeroModel.instance:getByHeroId(a.id)
	local bHeroMo = HeroModel.instance:getByHeroId(b.id)
	local aHasHero = aHeroMo ~= nil
	local bHasHero = bHeroMo ~= nil

	if aHasHero ~= bHasHero then
		return bHasHero
	end

	if aHeroMo then
		if not aHeroMo.exSkillLevel then
			local aSkillLevel = -1

			if bHeroMo then
				if not bHeroMo.exSkillLevel then
					local bSkillLevel = -1

					if aSkillLevel ~= bSkillLevel then
						return aSkillLevel < bSkillLevel
					end

					return a.id < b.id
				end
			end
		end
	end
end

function SummonLuckyBagChoiceListModel:initDatas(luckyBagId, poolId)
	self._poolId = poolId
	self._luckyBagId = luckyBagId
	self._selectHeroId = nil

	self:initList()
end

function SummonLuckyBagChoiceListModel:initList()
	local charIdList = self:getCharIdList()

	self.noGainList = {}
	self.ownList = {}

	for _, characterId in ipairs(charIdList) do
		local mo = SummonLuckyBagChoiceMO.New()

		mo:init(characterId)

		if mo:hasHero() then
			table.insert(self.ownList, mo)
		else
			table.insert(self.noGainList, mo)
		end
	end

	table.sort(self.ownList, sortFunc)
	table.sort(self.noGainList, sortFunc)
end

function SummonLuckyBagChoiceListModel:setSelectId(heroId)
	self._selectHeroId = heroId
end

function SummonLuckyBagChoiceListModel:getSelectId()
	return self._selectHeroId
end

function SummonLuckyBagChoiceListModel:getLuckyBagId()
	return self._luckyBagId
end

function SummonLuckyBagChoiceListModel:getPoolId()
	return self._poolId
end

function SummonLuckyBagChoiceListModel:getCharIdList()
	return SummonConfig.instance:getLuckyBagHeroIds(self._poolId, self._luckyBagId)
end

SummonLuckyBagChoiceListModel.instance = SummonLuckyBagChoiceListModel.New()

return SummonLuckyBagChoiceListModel
