-- chunkname: @modules/logic/character/view/CharacterGetViewContainer.lua

module("modules.logic.character.view.CharacterGetViewContainer", package.seeall)

local CharacterGetViewContainer = class("CharacterGetViewContainer", BaseViewContainer)

function CharacterGetViewContainer:buildViews()
	return {
		CharacterGetView.New(),
		CharacterSkinGetDetailView.New()
	}
end

return CharacterGetViewContainer
