-- chunkname: @modules/logic/versionactivity1_4/act136/model/Activity136ChoiceViewListModel.lua

module("modules.logic.versionactivity1_4.act136.model.Activity136ChoiceViewListModel", package.seeall)

local Activity136ChoiceViewListModel = class("Activity136ChoiceViewListModel", ListScrollModel)

function Activity136ChoiceViewListModel:onInit()
	self:clear()
end

function Activity136ChoiceViewListModel:reInit()
	self:clear()
end

local function _sortFunc(a, b)
	local aHeroMo = HeroModel.instance:getByHeroId(a.id)
	local bHeroMo = HeroModel.instance:getByHeroId(b.id)
	local aHasHero = not not aHeroMo
	local bHasHero = not not bHeroMo

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

function Activity136ChoiceViewListModel:setSelfSelectedCharacterList()
	local actId = Activity136Controller.instance:actId()
	local selfSelectedCharacterList = Activity136Config.instance:getSelfSelectCharacterIdList(actId)
	local list = {}

	for _, characterId in ipairs(selfSelectedCharacterList) do
		local mo = {}

		mo.id = characterId

		table.insert(list, mo)
	end

	table.sort(list, _sortFunc)
	self:setList(list)
end

Activity136ChoiceViewListModel.instance = Activity136ChoiceViewListModel.New()

return Activity136ChoiceViewListModel
