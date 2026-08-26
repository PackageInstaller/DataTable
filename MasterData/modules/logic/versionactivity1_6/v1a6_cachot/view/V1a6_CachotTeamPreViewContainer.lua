-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotTeamPreViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotTeamPreViewContainer", package.seeall)

local V1a6_CachotTeamPreViewContainer = class("V1a6_CachotTeamPreViewContainer", BaseViewContainer)

function V1a6_CachotTeamPreViewContainer:buildViews()
	return {
		V1a6_CachotTeamPreView.New()
	}
end

function V1a6_CachotTeamPreViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return V1a6_CachotTeamPreViewContainer
