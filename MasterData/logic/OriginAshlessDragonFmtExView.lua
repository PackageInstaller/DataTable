-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/view/OriginAshlessDragonFmtExView.lua

module("logic.extensions.originashlessdragon.view.OriginAshlessDragonFmtExView", package.seeall)

local OriginAshlessDragonFmtExView = class("OriginAshlessDragonFmtExView", ViewComponent)

function OriginAshlessDragonFmtExView:buildUI()
	OriginAshlessDragonFmtExView.super.buildUI(self)

	self._btnBudget = self:getGo("btnBudget")
end

function OriginAshlessDragonFmtExView:bindEvents()
	OriginAshlessDragonFmtExView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBudget, self._onClickBtnBudget, self)
end

function OriginAshlessDragonFmtExView:unbindEvents()
	OriginAshlessDragonFmtExView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBudget)
end

function OriginAshlessDragonFmtExView:onEnter()
	OriginAshlessDragonFmtExView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._phaseId = self._customFmtMo:getPhaseId()
	self._stageId = self._customFmtMo:getStageId()
	self._investBudget = self._customFmtMo:getInvestBudget()
end

function OriginAshlessDragonFmtExView:onExit()
	OriginAshlessDragonFmtExView.super.onExit(self)
end

function OriginAshlessDragonFmtExView:_onClickBtnBudget()
	UIStateManager.instance:push(ViewName.OriginAshlessDragonBudgetPopView, self._activityId, self._phaseId, self._stageId, self._investBudget)
end

return OriginAshlessDragonFmtExView
