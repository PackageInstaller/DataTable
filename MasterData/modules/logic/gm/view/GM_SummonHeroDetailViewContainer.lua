-- chunkname: @modules/logic/gm/view/GM_SummonHeroDetailViewContainer.lua

module("modules.logic.gm.view.GM_SummonHeroDetailViewContainer", package.seeall)

local GM_SummonHeroDetailViewContainer = class("GM_SummonHeroDetailViewContainer", BaseViewContainer)

function GM_SummonHeroDetailViewContainer:buildViews()
	return {
		GM_SummonHeroDetailView.New()
	}
end

function GM_SummonHeroDetailViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_SummonHeroDetailViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.SummonHeroDetailView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

function GM_SummonHeroDetailViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.SummonHeroDetailView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
end

return GM_SummonHeroDetailViewContainer
