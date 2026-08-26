-- chunkname: @modules/logic/dialogue/view/DialogueViewContainer.lua

module("modules.logic.dialogue.view.DialogueViewContainer", package.seeall)

local DialogueViewContainer = class("DialogueViewContainer", BaseViewContainer)

function DialogueViewContainer:buildViews()
	local views = {}

	table.insert(views, DialogueView.New())
	table.insert(views, DialogueChessView.New())
	table.insert(views, TabViewGroup.New(1, "#go_topleft"))

	return views
end

function DialogueViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return DialogueViewContainer
