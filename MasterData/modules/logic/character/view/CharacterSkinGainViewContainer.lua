-- chunkname: @modules/logic/character/view/CharacterSkinGainViewContainer.lua

module("modules.logic.character.view.CharacterSkinGainViewContainer", package.seeall)

local CharacterSkinGainViewContainer = class("CharacterSkinGainViewContainer", BaseViewContainer)

function CharacterSkinGainViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterSkinGainView.New())

	return views
end

return CharacterSkinGainViewContainer
