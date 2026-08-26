-- chunkname: @modules/logic/gm/view/GM_RecommendStoreViewContainer.lua

module("modules.logic.gm.view.GM_RecommendStoreViewContainer", package.seeall)

local GM_RecommendStoreViewContainer = class("GM_RecommendStoreViewContainer", BaseViewContainer)

function GM_RecommendStoreViewContainer:buildViews()
	return {
		GM_RecommendStoreView.New()
	}
end

function GM_RecommendStoreViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_RecommendStoreViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.RecommendStore_ShowAllBannerUpdate, viewObj._gm_showAllBannerUpdate, viewObj)
	GMController.instance:registerCallback(GMEvent.RecommendStore_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:registerCallback(GMEvent.RecommendStore_StopBannerLoopAnimUpdate, viewObj._gm_stopBannerLoopAnimUpdate, viewObj)
end

function GM_RecommendStoreViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_ShowAllBannerUpdate, viewObj._gm_showAllBannerUpdate, viewObj)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:unregisterCallback(GMEvent.RecommendStore_StopBannerLoopAnimUpdate, viewObj._gm_stopBannerLoopAnimUpdate, viewObj)
end

return GM_RecommendStoreViewContainer
