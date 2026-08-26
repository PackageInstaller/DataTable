-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114AnswerWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114AnswerWork", package.seeall)

local Activity114AnswerWork = class("Activity114AnswerWork", Activity114OpenViewWork)

function Activity114AnswerWork:onStart(context)
	if Activity114Model.instance.serverData.testEventId > 0 then
		self._viewName = ViewName.Activity114EventSelectView

		Activity114AnswerWork.super.onStart(self, context)
	else
		self.context.result = Activity114Enum.Result.Success

		self:onDone(true)
	end
end

return Activity114AnswerWork
