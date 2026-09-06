-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdWelfareMonthPopView.lua

module("logic.extensions.activitypopup.view.HdWelfareMonthPopView", package.seeall)

local HdWelfareMonthPopView = class("HdWelfareMonthPopView", ActivityPopupBase)

function HdWelfareMonthPopView:buildUI()
	HdWelfareMonthPopView.super.buildUI(self)

	self._btnGoto = self:getBtn("btnGoto")
end

function HdWelfareMonthPopView:bindEvents()
	HdWelfareMonthPopView.super.bindEvents(self)
	self._btnGoto:AddClickListener(self._onClickGoto, self)
end

function HdWelfareMonthPopView:unbindEvents()
	HdWelfareMonthPopView.super.unbindEvents(self)
	self._btnGoto:RemoveClickListener()
end

function HdWelfareMonthPopView:_onClickGoto()
	local cfg = self:getActivityPopupCfg()

	if cfg then
		if not ActivityPopupModel.instance:isHaveNextActivityViewId() then
			UIStateManager.instance:clear()
		end

		GotoMgr.gotoByString(cfg.jumpTo)
	end
end

return HdWelfareMonthPopView
