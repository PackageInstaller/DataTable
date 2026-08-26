-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEnterViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEnterViewContainer", package.seeall)

local V1a6_CachotEnterViewContainer = class("V1a6_CachotEnterViewContainer", BaseViewContainer)

function V1a6_CachotEnterViewContainer:buildViews()
	return {
		V1a6_CachotEnterView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function V1a6_CachotEnterViewContainer:buildTabViews(tabContainerId)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return V1a6_CachotEnterViewContainer
