-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionGetViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionGetViewContainer", package.seeall)

local V1a6_CachotCollectionGetViewContainer = class("V1a6_CachotCollectionGetViewContainer", BaseViewContainer)

function V1a6_CachotCollectionGetViewContainer:buildViews()
	return {
		V1a6_CachotCollectionGetView.New()
	}
end

return V1a6_CachotCollectionGetViewContainer
