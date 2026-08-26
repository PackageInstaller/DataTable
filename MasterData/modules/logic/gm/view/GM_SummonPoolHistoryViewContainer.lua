-- chunkname: @modules/logic/gm/view/GM_SummonPoolHistoryViewContainer.lua

module("modules.logic.gm.view.GM_SummonPoolHistoryViewContainer", package.seeall)

local GM_SummonPoolHistoryViewContainer = class("GM_SummonPoolHistoryViewContainer", BaseViewContainer)

function GM_SummonPoolHistoryViewContainer:buildViews()
	return {
		GM_SummonPoolHistoryView.New()
	}
end

function GM_SummonPoolHistoryViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_SummonPoolHistoryViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.SummonPoolHistoryView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_SummonPoolHistoryViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.SummonPoolHistoryView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_SummonPoolHistoryViewContainer
