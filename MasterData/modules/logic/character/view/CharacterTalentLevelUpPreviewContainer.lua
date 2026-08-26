-- chunkname: @modules/logic/character/view/CharacterTalentLevelUpPreviewContainer.lua

module("modules.logic.character.view.CharacterTalentLevelUpPreviewContainer", package.seeall)

local CharacterTalentLevelUpPreviewContainer = class("CharacterTalentLevelUpPreviewContainer", BaseViewContainer)

function CharacterTalentLevelUpPreviewContainer:buildViews()
	return {
		CharacterTalentLevelUpPreview.New()
	}
end

function CharacterTalentLevelUpPreviewContainer:buildTabViews(tabContainerId)
	return
end

return CharacterTalentLevelUpPreviewContainer
