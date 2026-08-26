-- chunkname: @modules/logic/character/view/CharacterSkinGetDetailViewContainer.lua

module("modules.logic.character.view.CharacterSkinGetDetailViewContainer", package.seeall)

local CharacterSkinGetDetailViewContainer = class("CharacterSkinGetDetailViewContainer", BaseViewContainer)

function CharacterSkinGetDetailViewContainer:buildViews()
	return {
		CharacterSkinGetDetailView.New()
	}
end

return CharacterSkinGetDetailViewContainer
