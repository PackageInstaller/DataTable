-- chunkname: @modules/logic/gm/view/GM_V3a1_GaoSiNiao_LevelViewContainer.lua

module("modules.logic.gm.view.GM_V3a1_GaoSiNiao_LevelViewContainer", package.seeall)

local GM_V3a1_GaoSiNiao_LevelViewContainer = class("GM_V3a1_GaoSiNiao_LevelViewContainer", BaseViewContainer)

function GM_V3a1_GaoSiNiao_LevelViewContainer:buildViews()
	return {
		GM_V3a1_GaoSiNiao_LevelView.New()
	}
end

function GM_V3a1_GaoSiNiao_LevelViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_V3a1_GaoSiNiao_LevelViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.V3a1_GaoSiNiao_LevelView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:registerCallback(GMEvent.V3a1_GaoSiNiao_LevelView_EnableEditModeOnSelect, viewObj._gm_enableEditModeOnSelect, viewObj)
end

function GM_V3a1_GaoSiNiao_LevelViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.V3a1_GaoSiNiao_LevelView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:unregisterCallback(GMEvent.V3a1_GaoSiNiao_LevelView_EnableEditModeOnSelect, viewObj._gm_enableEditModeOnSelect, viewObj)
end

return GM_V3a1_GaoSiNiao_LevelViewContainer
