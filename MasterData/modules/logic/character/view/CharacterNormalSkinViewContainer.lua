-- chunkname: @modules/logic/character/view/CharacterNormalSkinViewContainer.lua

module("modules.logic.character.view.CharacterNormalSkinViewContainer", package.seeall)

local CharacterNormalSkinViewContainer = class("CharacterNormalSkinViewContainer", BaseViewContainer)

function CharacterNormalSkinViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterNormalSkinView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btntopleft"))

	return views
end

function CharacterNormalSkinViewContainer:buildTabViews(tabContainerId)
	self._navigateView = NavigateButtonsView.New({
		true,
		false,
		false
	})

	return {
		self._navigateView
	}
end

return CharacterNormalSkinViewContainer
