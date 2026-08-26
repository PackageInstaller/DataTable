-- chunkname: @modules/logic/explore/view/ExploreArchivesViewContainer.lua

module("modules.logic.explore.view.ExploreArchivesViewContainer", package.seeall)

local ExploreArchivesViewContainer = class("ExploreArchivesViewContainer", BaseViewContainer)

function ExploreArchivesViewContainer:buildViews()
	return {
		ExploreArchivesView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function ExploreArchivesViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return ExploreArchivesViewContainer
