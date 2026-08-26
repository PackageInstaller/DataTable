-- chunkname: @modules/logic/gm/view/GM_NormalStoreViewContainer.lua

module("modules.logic.gm.view.GM_NormalStoreViewContainer", package.seeall)

local GM_NormalStoreViewContainer = class("GM_NormalStoreViewContainer", BaseViewContainer)

function GM_NormalStoreViewContainer:buildViews()
	return {
		GM_NormalStoreView.New()
	}
end

function GM_NormalStoreViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_NormalStoreViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.NormalStoreView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:registerCallback(GMEvent.NormalStoreView_ShowAllGoodsIdUpdate, viewObj._gm_showAllGoodsIdUpdate, viewObj)
end

function GM_NormalStoreViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.NormalStoreView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:unregisterCallback(GMEvent.NormalStoreView_ShowAllGoodsIdUpdate, viewObj._gm_showAllGoodsIdUpdate, viewObj)
end

return GM_NormalStoreViewContainer
