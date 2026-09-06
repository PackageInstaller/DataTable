-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintianmanwang/view/OrigintianmanwangmainView.lua

module("logic.extensions.origintianmanwang.view.OrigintianmanwangmainView", package.seeall)

local OrigintianmanwangmainView = class("OrigintianmanwangmainView", GulasmainView)

function OrigintianmanwangmainView:ctor()
	OrigintianmanwangmainView.super.ctor(self)
end

function OrigintianmanwangmainView:unbindEvents()
	OrigintianmanwangmainView.super.unbindEvents(self)
end

function OrigintianmanwangmainView:bindEvents()
	OrigintianmanwangmainView.super.bindEvents(self)
end

function OrigintianmanwangmainView:buildUI()
	OrigintianmanwangmainView.super.buildUI(self)
end

function OrigintianmanwangmainView:onExit()
	OrigintianmanwangmainView.super.onExit(self)
end

function OrigintianmanwangmainView:onEnter()
	OrigintianmanwangmainView.super.onEnter(self)
end

function OrigintianmanwangmainView:_onClickBtnClg1()
	self._info = GulasModel.instance:getInfo(self._activityId) or {}

	if not self._info.clgInfo then
		local list = GulasConfig.instance:getPhaseCfgListById(self._activityId) or {}

		if checknumber(self._info.passPhaseId) < #list then
			UIStateManager.instance:push(ViewName.OrigintianmanwanglevelsView, self._activityId)
		else
			TipsFacade.instance:openCommonTips("已全部通关")
		end
	end
end

function OrigintianmanwangmainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("origintianmanwangmainview_rule")
end

return OrigintianmanwangmainView
