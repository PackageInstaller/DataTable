-- chunkname: @modules/logic/survival/controller/work/SurvivalDailyReportPushWork.lua

module("modules.logic.survival.controller.work.SurvivalDailyReportPushWork", package.seeall)

local SurvivalDailyReportPushWork = class("SurvivalDailyReportPushWork", SurvivalMsgPushWork)

function SurvivalDailyReportPushWork:onStart(context)
	SurvivalModel.instance:setDailyReport(self._msg.json)
	SurvivalController.instance:_getInfo()
	self:onDone(true)
end

function SurvivalDailyReportPushWork:onViewClose(viewName)
	if viewName == ViewName.SurvivalReportView then
		self:onDone(true)
	end
end

function SurvivalDailyReportPushWork:clearWork()
	SurvivalDailyReportPushWork.super.clearWork(self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.onViewClose, self)
end

return SurvivalDailyReportPushWork
