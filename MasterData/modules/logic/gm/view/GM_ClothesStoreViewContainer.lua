-- chunkname: @modules/logic/gm/view/GM_ClothesStoreViewContainer.lua

module("modules.logic.gm.view.GM_ClothesStoreViewContainer", package.seeall)

local GM_ClothesStoreViewContainer = class("GM_ClothesStoreViewContainer", BaseViewContainer)

function GM_ClothesStoreViewContainer:buildViews()
	return {
		GM_ClothesStoreView.New()
	}
end

function GM_ClothesStoreViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_ClothesStoreViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.ClothesStoreView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_ClothesStoreViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.ClothesStoreView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_ClothesStoreViewContainer
