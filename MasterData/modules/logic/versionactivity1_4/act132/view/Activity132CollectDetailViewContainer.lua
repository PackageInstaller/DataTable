-- chunkname: @modules/logic/versionactivity1_4/act132/view/Activity132CollectDetailViewContainer.lua

module("modules.logic.versionactivity1_4.act132.view.Activity132CollectDetailViewContainer", package.seeall)

local Activity132CollectDetailViewContainer = class("Activity132CollectDetailViewContainer", BaseViewContainer)

function Activity132CollectDetailViewContainer:buildViews()
	return {
		Activity132CollectDetailView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function Activity132CollectDetailViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

function Activity132CollectDetailViewContainer:onContainerClose()
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem)
end

return Activity132CollectDetailViewContainer
