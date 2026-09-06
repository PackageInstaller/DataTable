-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiurep/view/HeartofaojiurepclgView.lua

module("logic.extensions.heartofaojiurep.view.HeartofaojiurepclgView", package.seeall)

local HeartofaojiurepclgView = class("HeartofaojiurepclgView", HeartofjieshenclgView)

function HeartofaojiurepclgView:ctor()
	HeartofaojiurepclgView.super.ctor(self)
end

function HeartofaojiurepclgView:unbindEvents()
	HeartofaojiurepclgView.super.unbindEvents(self)
end

function HeartofaojiurepclgView:bindEvents()
	HeartofaojiurepclgView.super.bindEvents(self)
end

function HeartofaojiurepclgView:buildUI()
	HeartofaojiurepclgView.super.buildUI(self)
end

function HeartofaojiurepclgView:onExit()
	HeartofaojiurepclgView.super.onExit(self)
end

function HeartofaojiurepclgView:onEnter()
	HeartofaojiurepclgView.super.onEnter(self)
end

function HeartofaojiurepclgView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.HeartofaojiureprankView, self._activityId, HeartofjieshenModel.TAB_HISTORY)
end

function HeartofaojiurepclgView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("heartofaojiurepclgview_rule")
end

function HeartofaojiurepclgView:_updateReward()
	MaterialMgr.resetAll(self._pointItemGo)

	local itemStr = self._actCfg.bubbleItem

	if not string.nilorempty(itemStr) then
		MaterialMgr.setCellByCfg(itemStr, self._pointItemGo)
	end
end

function HeartofaojiurepclgView:_getResultViewName()
	return ViewName.HeartofaojiurepresultView
end

return HeartofaojiurepclgView
