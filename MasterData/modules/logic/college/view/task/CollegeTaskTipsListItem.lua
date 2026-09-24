-- chunkname: @modules/logic/college/view/task/CollegeTaskTipsListItem.lua

module("modules.logic.college.view.task.CollegeTaskTipsListItem", package.seeall)

local CollegeTaskTipsListItem = class("CollegeTaskTipsListItem", LuaCompBase)

function CollegeTaskTipsListItem:init(go)
	self.go = go
	self._txtDesc = gohelper.findChildText(self.go, "#txt_desc")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)
	self._ignoreToastViewList = {
		ViewName.CollegeToastView,
		ViewName.ToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	}
end

function CollegeTaskTipsListItem:addEventListeners()
	self.addEventCb(self, CollegeController.instance, CollegeEvent.TaskFinish, self._onTaskFinish, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateTask, self._onUpdateTask, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnStoryPlayEnd, self._onStoryPlayEnd, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function CollegeTaskTipsListItem:removeEventListeners()
	return
end

function CollegeTaskTipsListItem:onUpdateMO(taskMo)
	self._taskMo = taskMo
	self._taskId = taskMo.id

	self:refreshUI()
end

function CollegeTaskTipsListItem:refreshUI()
	local desc = self._taskMo.co.description
	local param = {
		desc,
		self._taskMo.progress,
		self._taskMo.co.maxProgress
	}

	self._txtDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("college_tasktipsview_progress"), param)
end

function CollegeTaskTipsListItem:_onTaskFinish(taskId)
	if self._taskId ~= taskId then
		return
	end

	self._needPlayAnim = true

	self:refreshUI()
	self:tryPlayFinishAnim()
end

function CollegeTaskTipsListItem:_onUpdateTask()
	self:refreshUI()
end

function CollegeTaskTipsListItem:_onStoryPlayEnd()
	self:tryPlayFinishAnim()
end

function CollegeTaskTipsListItem:_onCloseViewFinish(viewName)
	if viewName == ViewName.CollegeMainView then
		return
	end

	self:tryPlayFinishAnim()
end

function CollegeTaskTipsListItem:tryPlayFinishAnim()
	if not self._needPlayAnim then
		return
	end

	if CollegeStoryHelper.instance:isPlayingStory() then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.CollegeMainView, self._ignoreToastViewList) then
		return
	end

	self._needPlayAnim = false

	self._animatorPlayer:Play("finish", self._onPlayFinishAnimDone, self)
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.TaskComplete)
end

function CollegeTaskTipsListItem:_onPlayFinishAnimDone()
	CollegeController.instance:dispatchEvent(CollegeEvent.OnTaskAnimDone, self._taskId, self)
end

return CollegeTaskTipsListItem
