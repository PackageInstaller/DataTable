-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114CheckOrAnswerWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114CheckOrAnswerWork", package.seeall)

local Activity114CheckOrAnswerWork = class("Activity114CheckOrAnswerWork", Activity114BaseWork)

function Activity114CheckOrAnswerWork:onStart(context)
	local eventCo = self.context.eventCo

	if eventCo.config.testId > 0 then
		self:getFlow():addWork(Activity114AnswerWork.New())
	elseif eventCo.config.isCheckEvent == 1 then
		self:getFlow():addWork(Activity114DiceViewWork.New())
	else
		self.context.result = Activity114Enum.Result.Success
	end

	self:getFlow():addWork(Activity114CheckResultWork.New())
	self:startFlow()
end

return Activity114CheckOrAnswerWork
