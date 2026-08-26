-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotLoadingViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotLoadingViewContainer", package.seeall)

local V1a6_CachotLoadingViewContainer = class("V1a6_CachotLoadingViewContainer", BaseViewContainer)

function V1a6_CachotLoadingViewContainer:buildViews()
	return {
		V1a6_CachotLoadingView.New()
	}
end

return V1a6_CachotLoadingViewContainer
