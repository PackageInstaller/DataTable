-- chunkname: @modules/logic/character/view/extra/CharacterWeaponViewContainer.lua

module("modules.logic.character.view.extra.CharacterWeaponViewContainer", package.seeall)

local CharacterWeaponViewContainer = class("CharacterWeaponViewContainer", BaseViewContainer)

function CharacterWeaponViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterWeaponView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function CharacterWeaponViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Hero3123WeaponView)

		return {
			self.navigateView
		}
	end
end

return CharacterWeaponViewContainer
