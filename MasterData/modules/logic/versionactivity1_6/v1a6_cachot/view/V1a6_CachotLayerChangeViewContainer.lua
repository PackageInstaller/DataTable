-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotLayerChangeViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotLayerChangeViewContainer", package.seeall)

local V1a6_CachotLayerChangeViewContainer = class("V1a6_CachotLayerChangeViewContainer", BaseViewContainer)

function V1a6_CachotLayerChangeViewContainer:buildViews()
	return {
		V1a6_CachotLayerChangeView.New()
	}
end

return V1a6_CachotLayerChangeViewContainer
