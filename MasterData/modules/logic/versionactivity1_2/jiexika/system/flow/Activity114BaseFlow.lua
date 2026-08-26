-- chunkname: @modules/logic/versionactivity1_2/jiexika/system/flow/Activity114BaseFlow.lua

module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114BaseFlow", package.seeall)

local Activity114BaseFlow = class("Activity114BaseFlow", FlowSequence)

function Activity114BaseFlow:initParams(params, isSkipWorks)
	self.context = params

	if self.context.eventId then
		self.context.eventCo = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, self.context.eventId)
	end

	self.context.nowWeek = Activity114Model.instance.serverData.week
	self.context.nowDay = self.context.nowDay or Activity114Model.instance.serverData.day
	self.context.nowRound = self.context.nowRound or Activity114Model.instance.serverData.round
	self.context.preAttention = self.context.preAttention or Activity114Model.instance.serverData.attention
	self.context.preAttrs = tabletool.copy(Activity114Model.instance.attrDict)

	self:setup(params, isSkipWorks)
end

function Activity114BaseFlow:setup(params, isSkipWorks)
	self:addWork(Activity114WaitStoryCloseEndWork.New())
	self:addWork(Activity114DelayWork.New(0))

	if not isSkipWorks then
		self:addNoSkipWork()
	else
		self:addSkipWork()
	end

	self:addRoundEndStory()
	self:addRoundEndTransition()
	self:addWork(Activity114ChangeEventWork.New())
	self:addWork(Activity114WaitStoryCloseEndWork.New())
	self:start(self.context)
end

function Activity114BaseFlow:addNoSkipWork()
	self:addEventBeginStory()
	self:addEventWork()
end

function Activity114BaseFlow:addSkipWork()
	self:addEventBeginStory()
	self:addEventWork()
end

function Activity114BaseFlow:addEventWork()
	return
end

function Activity114BaseFlow:getContext()
	return self.context
end

function Activity114BaseFlow:canFinishStory()
	local curWork = self._workList[self._curIndex]

	if not curWork then
		return true
	end

	local eventCo = self.context.eventCo

	if not eventCo then
		return true
	end

	if self.context.storyType == Activity114Enum.StoryType.Event and (eventCo.config.isCheckEvent > 0 or eventCo.config.testId > 0) then
		self:_closeCurStoryWork(curWork)

		return false
	end

	return true
end

function Activity114BaseFlow:_closeCurStoryWork(curWork)
	self.context.storyWorkEnd = true

	curWork:forceEndStory()
end

function Activity114BaseFlow:addEventBeginStory()
	local eventCo = self.context.eventCo

	if not eventCo then
		return
	end

	if eventCo.config.storyId <= 0 then
		return
	end

	self:addWork(Activity114StoryWork.New(eventCo.config.storyId, Activity114Enum.StoryType.Event))
end

function Activity114BaseFlow:addRoundEndStory()
	local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, self.context.nowDay, self.context.nowRound)

	if not roundCo then
		return
	end

	if roundCo.storyId <= 0 then
		return
	end

	if Activity114Model.instance.serverData.week ~= 1 then
		return
	end

	self:addWork(Activity114StoryWork.New(roundCo.storyId, Activity114Enum.StoryType.RoundEnd))
end

function Activity114BaseFlow:addRoundEndTransition()
	local roundCo = Activity114Config.instance:getRoundCo(Activity114Model.instance.id, self.context.nowDay, self.context.nowRound)

	if not roundCo then
		return
	end

	if roundCo.transition <= 0 then
		return
	end

	self:addWork(Activity114OpenTransitionViewWork.New(roundCo.transition))
end

return Activity114BaseFlow
