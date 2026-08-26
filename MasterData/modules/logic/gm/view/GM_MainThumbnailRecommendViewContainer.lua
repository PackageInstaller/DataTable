-- chunkname: @modules/logic/gm/view/GM_MainThumbnailRecommendViewContainer.lua

module("modules.logic.gm.view.GM_MainThumbnailRecommendViewContainer", package.seeall)

local GM_MainThumbnailRecommendViewContainer = class("GM_MainThumbnailRecommendViewContainer", BaseViewContainer)

function GM_MainThumbnailRecommendViewContainer:buildViews()
	return {
		GM_MainThumbnailRecommendView.New()
	}
end

function GM_MainThumbnailRecommendViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_MainThumbnailRecommendViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.MainThumbnailRecommendView_ShowAllBannerUpdate, viewObj._gm_showAllBannerUpdate, viewObj)
	GMController.instance:registerCallback(GMEvent.MainThumbnailRecommendView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:registerCallback(GMEvent.MainThumbnailRecommendView_StopBannerLoopAnimUpdate, viewObj._gm_stopBannerLoopAnimUpdate, viewObj)
end

function GM_MainThumbnailRecommendViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.MainThumbnailRecommendView_ShowAllBannerUpdate, viewObj._gm_showAllBannerUpdate, viewObj)
	GMController.instance:unregisterCallback(GMEvent.MainThumbnailRecommendView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:unregisterCallback(GMEvent.MainThumbnailRecommendView_StopBannerLoopAnimUpdate, viewObj._gm_stopBannerLoopAnimUpdate, viewObj)
end

return GM_MainThumbnailRecommendViewContainer
