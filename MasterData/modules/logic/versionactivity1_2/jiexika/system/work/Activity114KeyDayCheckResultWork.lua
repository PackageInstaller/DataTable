-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/work/Activity114KeyDayCheckResultWork.lua

module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114KeyDayCheckResultWork", package.seeall)

local Activity114KeyDayCheckResultWork = class("Activity114KeyDayCheckResultWork", Activity114BaseWork)

function Activity114KeyDayCheckResultWork:onStart(context)
	self:getFlow():addWork(Activity114StopStoryWork.New())
	self:getFlow():addWork(Activity114OpenAttrViewWork.New())

	local nextKeyDayCo = Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, self.context.nowDay)
	local isScoreE = false

	if not nextKeyDayCo then
		local _, _, _, totalScore = Activity114Helper.getWeekEndScore()

		isScoreE = totalScore < Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId.ScoreC)

		self:getFlow():addWork(Activity114WeekEndWork.New())
	end

	self.context.storyId = nil

	local eventCo = self.context.eventCo

	if self.context.result == Activity114Enum.Result.None then
		-- block empty
	elseif nextKeyDayCo and self.context.result == Activity114Enum.Result.Success or not nextKeyDayCo and not isScoreE then
		self:getFlow():addWork(Activity114StoryWork.New(eventCo.config.successStoryId, Activity114Enum.StoryType.Result))
	elseif nextKeyDayCo and self.context.result == Activity114Enum.Result.Fail or not nextKeyDayCo and isScoreE then
		self:getFlow():addWork(Activity114StoryWork.New(eventCo.config.failureStoryId, Activity114Enum.StoryType.Result))
	else
		logError("error :" .. tostring(isScoreE) .. " +++ " .. tostring(self.context.nowDay))
	end

	self:getFlow():addWork(Activity114StopStoryWork.New())
	self:startFlow()
end

return Activity114KeyDayCheckResultWork
