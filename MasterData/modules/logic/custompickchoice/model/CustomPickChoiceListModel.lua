-- chunkname: @modules/logic/custompickchoice/model/CustomPickChoiceListModel.lua

module("modules.logic.custompickchoice.model.CustomPickChoiceListModel", package.seeall)

local CustomPickChoiceListModel = class("CustomPickChoiceListModel", BaseModel)

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
						if aSkillLevel == 5 or bSkillLevel == 5 then
							return aSkillLevel ~= 5
						end

						return bSkillLevel < aSkillLevel
					end

					return a.id > b.id
				end
			end
		end
	end
end

function CustomPickChoiceListModel:onInit()
	self._selectIdList = {}
	self._selectIdMap = {}
	self.allHeroList = {}
	self.noGainList = {}
	self.ownList = {}
	self.maxSelectCount = nil
end

function CustomPickChoiceListModel:reInit()
	self:onInit()
end

function CustomPickChoiceListModel:initData(bePickChoiceHeroIdList, maxSelectCount)
	self:onInit()
	self:initList(bePickChoiceHeroIdList)

	self.maxSelectCount = maxSelectCount or 1
end

function CustomPickChoiceListModel:initList(bePickChoiceHeroIdList)
	self.noGainList = {}
	self.ownList = {}
	self.allHeroList = {}

	if not bePickChoiceHeroIdList then
		return
	end

	for _, heroId in ipairs(bePickChoiceHeroIdList) do
		local mo = SummonCustomPickChoiceMO.New()

		mo:init(heroId)

		if mo:hasHero() then
			table.insert(self.ownList, mo)
		else
			table.insert(self.noGainList, mo)
		end

		table.insert(self.allHeroList, mo)
	end

	table.sort(self.ownList, sortFunc)
end

function CustomPickChoiceListModel:setSelectId(heroId)
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

function CustomPickChoiceListModel:clearAllSelect()
	self._selectIdMap = {}
	self._selectIdList = {}
end

function CustomPickChoiceListModel:getSelectIds()
	return self._selectIdList
end

function CustomPickChoiceListModel:getSelectCount()
	if self._selectIdList then
		return #self._selectIdList
	end

	return 0
end

function CustomPickChoiceListModel:getMaxSelectCount()
	return self.maxSelectCount
end

function CustomPickChoiceListModel:isHeroIdSelected(heroId)
	if self._selectIdMap then
		return self._selectIdMap[heroId] ~= nil
	end

	return false
end

CustomPickChoiceListModel.instance = CustomPickChoiceListModel.New()

return CustomPickChoiceListModel
