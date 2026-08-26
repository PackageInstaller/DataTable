-- chunkname: @modules/logic/gm/view/GM_V3a1_GaoSiNiao_GameViewContainer.lua

module("modules.logic.gm.view.GM_V3a1_GaoSiNiao_GameViewContainer", package.seeall)

local GM_V3a1_GaoSiNiao_GameViewContainer = class("GM_V3a1_GaoSiNiao_GameViewContainer", BaseViewContainer)

function GM_V3a1_GaoSiNiao_GameViewContainer:buildViews()
	return {
		GM_V3a1_GaoSiNiao_GameView.New()
	}
end

function GM_V3a1_GaoSiNiao_GameViewContainer:onContainerClickModalMask()
	ViewMgr.instance:closeView(self.viewName)
end

function GM_V3a1_GaoSiNiao_GameViewContainer.addEvents(viewObj)
	GMController.instance:registerCallback(GMEvent.V3a1_GaoSiNiao_GameView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:registerCallback(GMEvent.V3a1_GaoSiNiao_GameView_OnClickSwitchMode, viewObj._gm_onClickSwitchMode, viewObj)
end

function GM_V3a1_GaoSiNiao_GameViewContainer.removeEvents(viewObj)
	GMController.instance:unregisterCallback(GMEvent.V3a1_GaoSiNiao_GameView_ShowAllTabIdUpdate, viewObj._gm_showAllTabIdUpdate, viewObj)
	GMController.instance:unregisterCallback(GMEvent.V3a1_GaoSiNiao_GameView_OnClickSwitchMode, viewObj._gm_onClickSwitchMode, viewObj)
end

return GM_V3a1_GaoSiNiao_GameViewContainer
