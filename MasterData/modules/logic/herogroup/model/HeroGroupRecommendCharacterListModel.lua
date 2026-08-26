-- chunkname: @modules/logic/herogroup/model/HeroGroupRecommendCharacterListModel.lua

module("modules.logic.herogroup.model.HeroGroupRecommendCharacterListModel", package.seeall)

local HeroGroupRecommendCharacterListModel = class("HeroGroupRecommendCharacterListModel", ListScrollModel)

function HeroGroupRecommendCharacterListModel:setCharacterList(infos)
	local moList = {}

	for i, character in ipairs(infos) do
		local characterMO = HeroGroupRecommendCharacterMO.New()

		characterMO:init(character)
		table.insert(moList, characterMO)
	end

	table.sort(moList, function(x, y)
		return x.rate > y.rate
	end)

	for i = #infos + 1, 5 do
		local characterMO = HeroGroupRecommendCharacterMO.New()

		characterMO:init()
		table.insert(moList, characterMO)
	end

	self:setList(moList)

	if #moList > 0 then
		for _, view in ipairs(self._scrollViews) do
			view:selectCell(1, true)
		end
	end
end

HeroGroupRecommendCharacterListModel.instance = HeroGroupRecommendCharacterListModel.New()

return HeroGroupRecommendCharacterListModel
