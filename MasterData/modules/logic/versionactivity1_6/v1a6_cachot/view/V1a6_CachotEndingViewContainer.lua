-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotEndingViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotEndingViewContainer", package.seeall)

local V1a6_CachotEndingViewContainer = class("V1a6_CachotEndingViewContainer", BaseViewContainer)

function V1a6_CachotEndingViewContainer:buildViews()
	return {
		V1a6_CachotEndingView.New()
	}
end

return V1a6_CachotEndingViewContainer
