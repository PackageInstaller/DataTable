-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114CheckWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114CheckWork", package.seeall)

local Activity114CheckWork = class("Activity114CheckWork", Activity114OpenViewWork)

function Activity114CheckWork:onStart(context)
	local eventCo = self.context.eventCo

	if eventCo.config.isCheckEvent == 1 or eventCo.config.testId > 0 and Activity114Model.instance.serverData.testEventId <= 0 then
		self._viewName = ViewName.Activity114EventSelectView

		Activity114CheckWork.super.onStart(self, context)
	elseif Activity114Model.instance.serverData.checkEventId > 0 then
		Activity114Rpc.instance:checkRequest(Activity114Model.instance.id, true, self.onCheckDone, self)
	else
		self.context.result = Activity114Enum.Result.Success

		self:onDone(true)
	end
end

function Activity114CheckWork:onCheckDone(cmd, resultCode, msg)
	self:onDone(resultCode == 0)
end

return Activity114CheckWork
