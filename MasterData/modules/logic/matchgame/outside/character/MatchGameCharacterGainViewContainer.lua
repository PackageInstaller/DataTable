-- chunkname: @modules/logic/matchgame/outside/character/MatchGameCharacterGainViewContainer.lua

module("modules.logic.matchgame.outside.character.MatchGameCharacterGainViewContainer", package.seeall)

local MatchGameCharacterGainViewContainer = class("MatchGameCharacterGainViewContainer", BaseViewContainer)

function MatchGameCharacterGainViewContainer:buildViews()
	return {
		MatchGameCharacterGainView.New()
	}
end

return MatchGameCharacterGainViewContainer
