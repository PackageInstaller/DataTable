-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTeamViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamViewContainer", package.seeall)

local V1a6_CachotTeamViewContainer = class("V1a6_CachotTeamViewContainer", BaseViewContainer)

function V1a6_CachotTeamViewContainer:buildViews()
	return {
		V1a6_CachotTeamItemListView.New(),
		V1a6_CachotTeamView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function V1a6_CachotTeamViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return V1a6_CachotTeamViewContainer
