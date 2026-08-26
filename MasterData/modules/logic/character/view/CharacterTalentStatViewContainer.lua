-- chunkname: @modules/logic/character/view/CharacterTalentStatViewContainer.lua

module("modules.logic.character.view.CharacterTalentStatViewContainer", package.seeall)

local CharacterTalentStatViewContainer = class("CharacterTalentStatViewContainer", BaseViewContainer)

function CharacterTalentStatViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterTalentStatView.New())

	return views
end

return CharacterTalentStatViewContainer
