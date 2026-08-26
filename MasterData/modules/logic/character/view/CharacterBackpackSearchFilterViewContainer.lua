-- chunkname: @modules/logic/character/view/CharacterBackpackSearchFilterViewContainer.lua

module("modules.logic.character.view.CharacterBackpackSearchFilterViewContainer", package.seeall)

local CharacterBackpackSearchFilterViewContainer = class("CharacterBackpackSearchFilterViewContainer", BaseViewContainer)

function CharacterBackpackSearchFilterViewContainer:buildViews()
	return {
		CharacterBackpackSearchFilterView.New()
	}
end

return CharacterBackpackSearchFilterViewContainer
