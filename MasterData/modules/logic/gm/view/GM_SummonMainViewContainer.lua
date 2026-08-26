-- chunkname: @modules/logic/gm/view/GM_SummonMainViewContainer.lua

module("modules.logic.gm.view.GM_SummonMainViewContainer", package.seeall)

local GM_SummonMainViewContainer = class("GM_SummonMainViewContainer", BaseViewContainer)

function GM_SummonMainViewContainer:buildViews()
	return {
		GM_SummonMainView.New()
	}
end

function GM_SummonMainViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_SummonMainViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.SummonMainView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_SummonMainViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.SummonMainView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_SummonMainViewContainer
