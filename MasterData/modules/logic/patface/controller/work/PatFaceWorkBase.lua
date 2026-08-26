-- chunkname: @modules/logic/patface/controller/work/PatFaceWorkBase.lua

module("modules.logic.patface.controller.work.PatFaceWorkBase", package.seeall)

local PatFaceWorkBase = class("PatFaceWorkBase", BaseWork)

function PatFaceWorkBase:ctor(patFaceId)
	self._patFaceId = patFaceId
end

function PatFaceWorkBase:onStart(context)
	if not self._patFaceId or self._patFaceId == PatFaceEnum.NoneNum then
		self:patComplete()

		return
	end

	self._patViewName = PatFaceConfig.instance:getPatFaceViewName(self._patFaceId)
	self._patStoryId = PatFaceConfig.instance:getPatFaceStoryId(self._patFaceId)
	self._patFaceType = context and context.patFaceType

	local isCanPat = self:checkCanPat()

	if isCanPat then
		self:startPat()
	else
		self:patComplete()
	end
end

function PatFaceWorkBase:checkCanPat()
	local customerCheckFun = PatFaceEnum.CustomCheckCanPatFun[self._patFaceId]

	return customerCheckFun and customerCheckFun(self._patFaceId) or self:defaultCheckCanPat()
end

function PatFaceWorkBase:defaultCheckCanPat()
	local result = false
	local actId = PatFaceConfig.instance:getPatFaceActivityId(self._patFaceId)

	if actId and actId ~= PatFaceEnum.NoneNum then
		local activityState = ActivityHelper.getActivityStatus(actId)

		result = activityState == ActivityEnum.ActivityStatus.Normal
	else
		local str = string.format("PatFaceWorkBase:defaultCheckCanPat error, actId invalid,patFaceId:%s, actId:%s", self._patFaceId, actId)

		logNormal(str)
	end

	return result
end

function PatFaceWorkBase:startPat()
	if not string.nilorempty(self._patViewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
		self:patView()
	elseif self._patStoryId and self._patStoryId ~= PatFaceEnum.NoneNum then
		self:patStory()
	else
		self:patComplete()
	end
end

function PatFaceWorkBase:onResume()
	if not string.nilorempty(self._patViewName) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	end
end

function PatFaceWorkBase:patView()
	local customerPatViewFun = PatFaceEnum.CustomPatFun[self._patFaceId]

	if customerPatViewFun then
		customerPatViewFun(self._patFaceId)
	else
		ViewMgr.instance:openView(self._patViewName)
	end
end

function PatFaceWorkBase:patStory()
	local storyId = self._patStoryId

	if StoryModel.instance:isStoryHasPlayed(storyId) then
		self:onPlayPatStoryFinish()

		return
	end

	StoryController.instance:playStory(storyId, nil, self.onPlayPatStoryFinish, self)
end

function PatFaceWorkBase:onCloseViewFinish(viewName)
	if string.nilorempty(self._patViewName) or self._patViewName == viewName then
		self:patComplete()
	end
end

function PatFaceWorkBase:onPlayPatStoryFinish()
	self:patComplete()
end

function PatFaceWorkBase:patComplete()
	self:onDone(true)
end

function PatFaceWorkBase:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
end

return PatFaceWorkBase
