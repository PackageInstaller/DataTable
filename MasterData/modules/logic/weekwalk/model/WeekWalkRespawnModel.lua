-- chunkname: @modules/logic/weekwalk/model/WeekWalkRespawnModel.lua

module("modules.logic.weekwalk.model.WeekWalkRespawnModel", package.seeall)

local WeekWalkRespawnModel = class("WeekWalkRespawnModel", ListScrollModel)

function WeekWalkRespawnModel:setRespawnList()
	local info = WeekWalkModel.instance:getInfo()

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.WeekWalk)

	local list = CharacterBackpackCardListModel.instance:getCharacterCardList()
	local result = {}

	for i, v in ipairs(list) do
		local hp = info:getHeroHp(v.heroId)

		if hp and hp <= 0 then
			table.insert(result, v)
		end
	end

	self:setList(result)
end

WeekWalkRespawnModel.instance = WeekWalkRespawnModel.New()

return WeekWalkRespawnModel
