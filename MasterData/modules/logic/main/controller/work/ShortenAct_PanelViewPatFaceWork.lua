-- chunkname: @modules/logic/main/controller/work/ShortenAct_PanelViewPatFaceWork.lua

module("modules.logic.main.controller.work.ShortenAct_PanelViewPatFaceWork", package.seeall)

local sf = string.format
local ShortenAct_PanelViewPatFaceWork = class("ShortenAct_PanelViewPatFaceWork", PatFaceWorkBase)

function ShortenAct_PanelViewPatFaceWork:_viewName()
	return PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)
end

function ShortenAct_PanelViewPatFaceWork:_actId()
	return PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)
end

function ShortenAct_PanelViewPatFaceWork:checkCanPat()
	local actId = self:_actId()

	return ActivityHelper.getActivityStatus(actId, true) == ActivityEnum.ActivityStatus.Normal
end

function ShortenAct_PanelViewPatFaceWork:startPat()
	self:_startBlock()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189InfoReply, self._onReceiveGetAct189InfoReply, self)
	Activity189Controller.instance:sendGetAct189InfoRequest(self:_actId())
end

function ShortenAct_PanelViewPatFaceWork:clearWork()
	self:_endBlock()
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189InfoReply, self._onReceiveGetAct189InfoReply, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function ShortenAct_PanelViewPatFaceWork:_onOpenViewFinish(openingViewName)
	local viewName = self:_viewName()

	if openingViewName ~= viewName then
		return
	end

	self:_endBlock()
end

function ShortenAct_PanelViewPatFaceWork:_onCloseViewFinish(closingViewName)
	local viewName = self:_viewName()

	if closingViewName ~= viewName then
		return
	end

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	self:patComplete()
end

function ShortenAct_PanelViewPatFaceWork:_onReceiveGetAct189InfoReply()
	local viewName = self:_viewName()

	if not self:_isClaimable() then
		self:patComplete()

		return
	end

	if string.nilorempty(viewName) then
		logError(sf("excel:P拍脸表.xlsx - sheet:export_拍脸 error id: %s, patFaceActivityId: %s, 没配 'patFaceViewName' !!", self._patFaceId, self:_actId()))
		self:patComplete()

		return
	end

	if not ViewName[viewName] then
		logError(sf("excel:P拍脸表.xlsx - sheet:export_拍脸 id: %s, patFaceActivityId: %s, patFaceViewName: %s, error: modules_views.%s 不存在", self._patFaceId, self:_actId(), viewName, viewName))
		self:patComplete()

		return
	end

	ViewMgr.instance:openView(viewName)
end

function ShortenAct_PanelViewPatFaceWork:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function ShortenAct_PanelViewPatFaceWork:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function ShortenAct_PanelViewPatFaceWork:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

function ShortenAct_PanelViewPatFaceWork:_isClaimable()
	return Activity189Model.instance:isClaimable(self:_actId())
end

return ShortenAct_PanelViewPatFaceWork
