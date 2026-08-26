-- chunkname: @modules/logic/weekwalk/model/WeekWalkCharacterModel.lua

module("modules.logic.weekwalk.model.WeekWalkCharacterModel", package.seeall)

local WeekWalkCharacterModel = class("WeekWalkCharacterModel", CharacterModel)

function WeekWalkCharacterModel:_setCharacterCardList(cardList)
	WeekWalkCardListModel.instance:setCharacterList(cardList)
end

WeekWalkCharacterModel.instance = WeekWalkCharacterModel.New()

return WeekWalkCharacterModel
