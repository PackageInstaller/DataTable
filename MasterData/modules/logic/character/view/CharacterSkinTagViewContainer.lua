-- chunkname: @modules/logic/character/view/CharacterSkinTagViewContainer.lua

module("modules.logic.character.view.CharacterSkinTagViewContainer", package.seeall)

local CharacterSkinTagViewContainer = class("CharacterSkinTagViewContainer", BaseViewContainer)

function CharacterSkinTagViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterSkinTagView.New())

	return views
end

return CharacterSkinTagViewContainer
