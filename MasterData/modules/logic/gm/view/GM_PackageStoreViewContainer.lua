-- chunkname: @modules/logic/gm/view/GM_PackageStoreViewContainer.lua

module("modules.logic.gm.view.GM_PackageStoreViewContainer", package.seeall)

local GM_PackageStoreViewContainer = class("GM_PackageStoreViewContainer", BaseViewContainer)

function GM_PackageStoreViewContainer:buildViews()
	return {
		GM_PackageStoreView.New()
	}
end

function GM_PackageStoreViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_PackageStoreViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.PackageStoreView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:registerCallback(GMEvent.PackageStoreView_ShowAllItemIdUpdate, viewObj._gm_showAllItemIdUpdate, viewObj)
end

function GM_PackageStoreViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.PackageStoreView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:unregisterCallback(GMEvent.PackageStoreView_ShowAllItemIdUpdate, viewObj._gm_showAllItemIdUpdate, viewObj)
end

return GM_PackageStoreViewContainer
