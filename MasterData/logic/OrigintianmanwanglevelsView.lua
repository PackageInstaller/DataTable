-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintianmanwang/view/OrigintianmanwanglevelsView.lua

module("logic.extensions.origintianmanwang.view.OrigintianmanwanglevelsView", package.seeall)

local OrigintianmanwanglevelsView = class("OrigintianmanwanglevelsView", GulaslevelsView)

function OrigintianmanwanglevelsView:ctor()
	OrigintianmanwanglevelsView.super.ctor(self)
end

function OrigintianmanwanglevelsView:unbindEvents()
	OrigintianmanwanglevelsView.super.unbindEvents(self)
end

function OrigintianmanwanglevelsView:bindEvents()
	OrigintianmanwanglevelsView.super.bindEvents(self)
end

function OrigintianmanwanglevelsView:buildUI()
	OrigintianmanwanglevelsView.super.buildUI(self)
end

function OrigintianmanwanglevelsView:onExit()
	OrigintianmanwanglevelsView.super.onExit(self)
end

function OrigintianmanwanglevelsView:onEnter()
	OrigintianmanwanglevelsView.super.onEnter(self)
end

function OrigintianmanwanglevelsView:_onClickReward()
	UIStateManager.instance:push(ViewName.OrigintianmanwangpopView, self._activityId)
end

function OrigintianmanwanglevelsView:_onClickPkBtn(data)
	GulasController.instance:openFmtView(self._activityId, self._currPhaseId, data.stageId, ViewName.OrigintianmanwangextView, self._viewPresentor.viewName)
end

function OrigintianmanwanglevelsView:_onClickTip()
	TipsFacade.instance:openRulesView("origintianmanwangmainview_rule")
end

return OrigintianmanwanglevelsView
