-- chunkname: @modules/logic/character/view/extra/CharacterWeaponEffectViewContainer.lua

module("modules.logic.character.view.extra.CharacterWeaponEffectViewContainer", package.seeall)

local CharacterWeaponEffectViewContainer = class("CharacterWeaponEffectViewContainer", BaseViewContainer)

function CharacterWeaponEffectViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterWeaponEffectView.New())

	return views
end

return CharacterWeaponEffectViewContainer
