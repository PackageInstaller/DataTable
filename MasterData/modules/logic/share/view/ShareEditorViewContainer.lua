-- chunkname: @modules/logic/share/view/ShareEditorViewContainer.lua

module("modules.logic.share.view.ShareEditorViewContainer", package.seeall)

local ShareEditorViewContainer = class("ShareEditorViewContainer", BaseViewContainer)

function ShareEditorViewContainer:buildViews()
	return {
		ShareEditorView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function ShareEditorViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return ShareEditorViewContainer
