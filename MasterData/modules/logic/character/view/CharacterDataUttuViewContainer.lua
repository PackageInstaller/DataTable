-- chunkname: @modules/logic/character/view/CharacterDataUttuViewContainer.lua

module("modules.logic.character.view.CharacterDataUttuViewContainer", package.seeall)

local CharacterDataUttuViewContainer = class("CharacterDataUttuViewContainer", BaseViewContainer)

function CharacterDataUttuViewContainer:buildViews()
	return {
		CharacterDataUttuView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function CharacterDataUttuViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return CharacterDataUttuViewContainer
