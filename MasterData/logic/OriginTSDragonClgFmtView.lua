-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origintsdragonclg/view/OriginTSDragonClgFmtView.lua

module("logic.extensions.origintsdragonclg.view.OriginTSDragonClgFmtView", package.seeall)

local OriginTSDragonClgFmtView = class("OriginTSDragonClgFmtView", ViewComponent)

function OriginTSDragonClgFmtView:ctor()
	OriginTSDragonClgFmtView.super.ctor(self)
end

function OriginTSDragonClgFmtView:unbindEvents()
	OriginTSDragonClgFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnShow)
end

function OriginTSDragonClgFmtView:bindEvents()
	OriginTSDragonClgFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnShow, self._onClickBtnShow, self)
end

function OriginTSDragonClgFmtView:buildUI()
	OriginTSDragonClgFmtView.super.buildUI(self)

	self._btnShow = self:getGo("btnShow")
	self._Content = self:getTxt("buffTips/scrView/Viewport/Content")
end

function OriginTSDragonClgFmtView:onExit()
	OriginTSDragonClgFmtView.super.onExit(self)
end

function OriginTSDragonClgFmtView:onEnter()
	OriginTSDragonClgFmtView.super.onEnter(self)

	local fmtMo = self:getFirstParam()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(fmtMo._activityId)
	self._phaseId = checknumber(fmtMo._phaseId)
	self._stageId = checknumber(fmtMo._stageId)
	self._bePointedToMap = checktable(fmtMo._bePointedToMap)

	if self._activityId <= 0 then
		self._activityId = 591001
	end

	local curPhasePuzNum = OriginTSDragonClgModel.instance:getCurPuzNum(self._activityId, self._phaseId)
	local curPhaseCfg = OriginTSDragonClgConfig.instance:getPhaseCfgById(self._activityId, self._phaseId)

	if curPhasePuzNum < curPhaseCfg.puzzleLimit then
		UIStateManager.instance:push(ViewName.OriginTSDragonClgSelectPuzView, self._activityId, self._phaseId, self._stageId, self._bePointedToMap)
	end

	local stageCfg = OriginTSDragonClgConfig.instance:getStageCfg(self._activityId, self._phaseId, self._stageId)

	self._Content.text = stageCfg.passDesc
end

function OriginTSDragonClgFmtView:_onClickBtnShow()
	UIStateManager.instance:push(ViewName.OriginTSDragonClgSelectPuzView, self._activityId, self._phaseId, self._stageId, self._bePointedToMap)
end

return OriginTSDragonClgFmtView
