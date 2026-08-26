-- chunkname: @modules/logic/signin/controller/work/ActivityDoubleFestivalSignWork_1_3.lua

module("modules.logic.signin.controller.work.ActivityDoubleFestivalSignWork_1_3", package.seeall)

local ActivityDoubleFestivalSignWork_1_3 = class("ActivityDoubleFestivalSignWork_1_3", BaseWork)
local actId = ActivityEnum.Activity.DoubleFestivalSign_1_3

function ActivityDoubleFestivalSignWork_1_3:onStart()
	if not ActivityModel.instance:isActOnLine(actId) then
		self:onDone(true)

		return
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self)
	Activity101Rpc.instance:sendGet101InfosRequest(actId)
end

function ActivityDoubleFestivalSignWork_1_3:_refreshNorSignActivity()
	if not ActivityType101Model.instance:isType101RewardCouldGetAnyOne(actId) then
		self:onDone(true)

		return
	end

	ViewMgr.instance:openView(ViewName.ActivityDoubleFestivalSignPaiLianView_1_3)
end

function ActivityDoubleFestivalSignWork_1_3:_onCloseViewFinish(viewName)
	if viewName == ViewName.ActivityDoubleFestivalSignPaiLianView_1_3 then
		self:onDone(true)
	end
end

function ActivityDoubleFestivalSignWork_1_3:_onOpenViewFinish(viewName)
	if viewName ~= ViewName.ActivityDoubleFestivalSignPaiLianView_1_3 then
		return
	end

	self:_endBlock()
end

function ActivityDoubleFestivalSignWork_1_3:clearWork()
	self:_endBlock()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._refreshNorSignActivity, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
end

function ActivityDoubleFestivalSignWork_1_3:_endBlock()
	if not self:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function ActivityDoubleFestivalSignWork_1_3:_isBlock()
	return not not UIBlockMgr.instance:isBlock()
end

return ActivityDoubleFestivalSignWork_1_3
