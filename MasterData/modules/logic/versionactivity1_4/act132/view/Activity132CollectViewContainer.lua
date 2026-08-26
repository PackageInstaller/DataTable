-- chunkname: @modules/logic/versionactivity1_4/act132/view/Activity132CollectViewContainer.lua

module("modules.logic.versionactivity1_4.act132.view.Activity132CollectViewContainer", package.seeall)

local Activity132CollectViewContainer = class("Activity132CollectViewContainer", BaseViewContainer)

function Activity132CollectViewContainer:buildViews()
	return {
		Activity132CollectView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Activity132CollectViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return Activity132CollectViewContainer
