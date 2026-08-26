-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionSelectViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionSelectViewContainer", package.seeall)

local V1a6_CachotCollectionSelectViewContainer = class("V1a6_CachotCollectionSelectViewContainer", BaseViewContainer)

function V1a6_CachotCollectionSelectViewContainer:buildViews()
	return {
		V1a6_CachotCollectionSelectView.New()
	}
end

return V1a6_CachotCollectionSelectViewContainer
