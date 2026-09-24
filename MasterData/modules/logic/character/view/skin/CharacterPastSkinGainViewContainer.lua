-- chunkname: @modules/logic/character/view/skin/CharacterPastSkinGainViewContainer.lua

module("modules.logic.character.view.skin.CharacterPastSkinGainViewContainer", package.seeall)

local CharacterPastSkinGainViewContainer = class("CharacterPastSkinGainViewContainer", BaseViewContainer)

function CharacterPastSkinGainViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterPastSkinGainView.New())

	return views
end

return CharacterPastSkinGainViewContainer
