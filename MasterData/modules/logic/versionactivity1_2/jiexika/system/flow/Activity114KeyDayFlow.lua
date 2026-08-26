-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/flow/Activity114KeyDayFlow.lua

module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114KeyDayFlow", package.seeall)

local Activity114KeyDayFlow = class("Activity114KeyDayFlow", Activity114BaseFlow)

function Activity114KeyDayFlow:addEventWork()
	if Activity114Model.instance.serverData.checkEventId <= 0 and Activity114Model.instance.serverData.testEventId <= 0 then
		self:addWork(Activity114KeyDayReqWork.New())
	end

	if self.context.eventCo.config.testId > 0 then
		self:addWork(Activity114AnswerWork.New())
	end

	if self.context.eventCo.config.isCheckEvent == 1 then
		self:addWork(Activity114DelayWork.New(0.2))
		self:addWork(Activity114CheckWork.New())
		self:addWork(Activity114DiceViewWork.New())
		self:addWork(Activity114KeyDayCheckResultWork.New())
	else
		self:addWork(Activity114StopStoryWork.New())

		if self.context.eventCo.config.testId > 0 then
			self:addWork(Activity114OpenViewWork.New(ViewName.Activity114TransitionView))
		end
	end
end

return Activity114KeyDayFlow
