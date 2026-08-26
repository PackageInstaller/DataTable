-- chunkname: @modules/logic/character/view/CharacterGuideTalentViewContainer.lua

module("modules.logic.character.view.CharacterGuideTalentViewContainer", package.seeall)

local CharacterGuideTalentViewContainer = class("CharacterGuideTalentViewContainer", BaseViewContainer)

function CharacterGuideTalentViewContainer:buildViews()
	return {
		CharacterGuideTalentView.New()
	}
end

return CharacterGuideTalentViewContainer
