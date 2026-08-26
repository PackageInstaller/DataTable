-- chunkname: @modules/logic/summon/model/SummonCustomPickChoiceListModel.lua

module("modules.logic.summon.model.SummonCustomPickChoiceListModel", package.seeall)

local SummonCustomPickChoiceListModel = class("SummonCustomPickChoiceListModel", ListScrollModel)

function SummonCustomPickChoiceListModel:onInit()
	self:clear()
end

function SummonCustomPickChoiceListModel:reInit()
	self:clear()
end

function SummonCustomPickChoiceListModel:initDatas(poolId)
	self._poolId = poolId
	self._selectIdList = {}
	self._selectIdMap = {}

	self:initList()
end

SummonCustomPickChoiceListModel.SkillLevel2Order = {
	[0] = 50,
	40,
	30,
	20,
	10,
	60
}

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
						if not SummonCustomPickChoiceListModel.SkillLevel2Order[aSkillLevel] then
							local aOrder = 999

							if not SummonCustomPickChoiceListModel.SkillLevel2Order[bSkillLevel] then
								local bOrder = 999

								return aOrder < bOrder
							end
						end
					end

					return a.id > b.id
				end
			end
		end
	end
end

function SummonCustomPickChoiceListModel:initList()
	local charIdList = self:getCharIdList()

	self.noGainList = {}
	self.ownList = {}

	for _, characterId in ipairs(charIdList) do
		local mo = SummonCustomPickChoiceMO.New()

		mo:init(characterId)

		if mo:hasHero() then
			table.insert(self.ownList, mo)
		else
			table.insert(self.noGainList, mo)
		end
	end

	local summonPoolCfg = SummonConfig.instance:getSummonPool(self._poolId)

	if summonPoolCfg and summonPoolCfg.type ~= SummonEnum.Type.CustomPick then
		table.sort(self.ownList, sortFunc)
		table.sort(self.noGainList, sortFunc)
	end
end

function SummonCustomPickChoiceListModel:setSelectId(heroId)
	if not self._selectIdList then
		return
	end

	if self._selectIdMap[heroId] then
		self._selectIdMap[heroId] = nil

		tabletool.removeValue(self._selectIdList, heroId)
	else
		self._selectIdMap[heroId] = true

		table.insert(self._selectIdList, heroId)
	end
end

function SummonCustomPickChoiceListModel:clearSelectIds()
	self._selectIdMap = {}
	self._selectIdList = {}
end

function SummonCustomPickChoiceListModel:getSelectIds()
	return self._selectIdList
end

function SummonCustomPickChoiceListModel:getMaxSelectCount()
	return SummonCustomPickModel.instance:getMaxSelectCount(self._poolId)
end

function SummonCustomPickChoiceListModel:getSelectCount()
	if self._selectIdList then
		return #self._selectIdList
	end

	return 0
end

function SummonCustomPickChoiceListModel:isHeroIdSelected(heroId)
	if self._selectIdMap then
		return self._selectIdMap[heroId] ~= nil
	end

	return false
end

function SummonCustomPickChoiceListModel:getPoolId()
	return self._poolId
end

function SummonCustomPickChoiceListModel:getPoolType()
	local summonPoolCfg = SummonConfig.instance:getSummonPool(self._poolId)

	return summonPoolCfg.type or SummonEnum.Type.Normal
end

function SummonCustomPickChoiceListModel:getCharIdList()
	local summonPoolCfg = SummonConfig.instance:getSummonPool(self._poolId)

	if summonPoolCfg.type == SummonEnum.Type.StrongCustomOnePick then
		local summonIdStr = summonPoolCfg.param

		return (string.splitToNumber(summonIdStr, "#"))
	end

	local rare2Cfg = SummonConfig.instance:getSummon(self._poolId)

	if rare2Cfg then
		local summonIdStr = rare2Cfg[SummonEnum.CustomPickRare].summonId

		return (string.splitToNumber(summonIdStr, "#"))
	end

	return {}
end

SummonCustomPickChoiceListModel.instance = SummonCustomPickChoiceListModel.New()

return SummonCustomPickChoiceListModel
