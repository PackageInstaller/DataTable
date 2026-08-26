-- chunkname: @modules/logic/main/controller/work/WeekwalkHeart_PanelViewPatFaceWork.lua

module("modules.logic.main.controller.work.WeekwalkHeart_PanelViewPatFaceWork", package.seeall)

local WeekwalkHeart_PanelViewPatFaceWork = class("WeekwalkHeart_PanelViewPatFaceWork", PatFaceWorkBase)

WeekwalkHeart_PanelViewPatFaceWork.SigninId = 530007

function WeekwalkHeart_PanelViewPatFaceWork:_viewName()
	return PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)
end

function WeekwalkHeart_PanelViewPatFaceWork:_actId()
	return PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)
end

function WeekwalkHeart_PanelViewPatFaceWork:checkCanPat()
	local actId = self:_actId()
	local canPat = false

	if ActivityHelper.getActivityStatus(actId, true) == ActivityEnum.ActivityStatus.Normal then
		local taskmo = TaskModel.instance:getTaskById(WeekwalkHeart_PanelViewPatFaceWork.SigninId)

		if taskmo and taskmo.finishCount <= 0 then
			canPat = true
		end
	end

	return canPat
end

function WeekwalkHeart_PanelViewPatFaceWork:startPat()
	self:_startBlock()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	Activity189Controller.instance:registerCallback(Activity189Event.onReceiveGetAct189InfoReply, self._onReceiveGetAct189InfoReply, self)
	Activity189Controller.instance:sendGetAct189InfoRequest(self:_actId())
end

function WeekwalkHeart_PanelViewPatFaceWork:clearWork()
	self:_endBlock()
	Activity189Controller.instance:unregisterCallback(Activity189Event.onReceiveGetAct189InfoReply, self._onReceiveGetAct189InfoReply, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function WeekwalkHeart_PanelViewPatFaceWork:_onOpenViewFinish(openingViewName)
	local viewName = self:_viewName()

	if openingViewName ~= viewName then
		return
	end

	self:_endBlock()
end

function WeekwalkHeart_PanelViewPatFaceWork:_onCloseViewFinish(closingViewName)
	local viewName = self:_viewName()

	if closingViewName ~= viewName then
		return
	end

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	self:patComplete()
end

function WeekwalkHeart_PanelViewPatFaceWork:_onReceiveGetAct189InfoReply()
	local viewName = self:_viewName()

	if not self:_isClaimable() then
		self:patComplete()

		return
	end

	ViewMgr.instance:openView(viewName)
end

function WeekwalkHeart_PanelViewPatFaceWork:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function WeekwalkHeart_PanelViewPatFaceWork:_startBlock()
	if self:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function WeekwalkHeart_PanelViewPatFaceWork:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

function WeekwalkHeart_PanelViewPatFaceWork:_isClaimable()
	return Activity189Model.instance:isClaimable(self:_actId())
end

return WeekwalkHeart_PanelViewPatFaceWork
