-- chunkname: @modules/logic/character/view/CharacterRankUpResultViewContainer.lua

module("modules.logic.character.view.CharacterRankUpResultViewContainer", package.seeall)

local CharacterRankUpResultViewContainer = class("CharacterRankUpResultViewContainer", BaseViewContainer)

function CharacterRankUpResultViewContainer:buildViews()
	return {
		CharacterRankUpResultView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function CharacterRankUpResultViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		}, 100)
	}
end

return CharacterRankUpResultViewContainer
