-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskCompeleteView.lua

module("logic.extensions.task.view.TaskCompeleteView", package.seeall)

local TaskCompeleteView = class("TaskCompeleteView", ViewComponent)

function TaskCompeleteView:buildUI()
	self._Nego_FinishEffect = self:getGo("Nego_FinishEffect")
end

function TaskCompeleteView:onEnterFinished()
	self:_playEffect()
end

function TaskCompeleteView:_onTweenFinish()
	removetimer(self._onTweenFinish, self)
	self:close()
end

function TaskCompeleteView:onEnter()
	TaskController.instance.isDoingTaskCompUI = true
end

function TaskCompeleteView:onExit()
	self:_stopEffect()

	TaskController.instance.isDoingTaskCompUI = nil

	GlobalDispatcher:dispatch(GlobalNotify.CloseTaskCompleteView)
end

function TaskCompeleteView:onViewShowByHigherPriority()
	self:_playEffect()
end

function TaskCompeleteView:_playEffect()
	if not self._taskEffect then
		local isTaskFinish = true
		local taskStep = self:getFirstParam()

		if taskStep and taskStep:getNextStepId() then
			isTaskFinish = nil
		end

		isTaskFinish = true

		local resPath

		self._taskEffect = UIEffectManager.instance:playEffect(self, isTaskFinish and "fx_ui_renwuwancheng/fx_renwuwancheng.prefab" or "fx_ui_renwuwancheng/fx_renwubuzhouwancheng.prefab", self._Nego_FinishEffect, 0, 0, false, nil, nil, self._onEffLoaded, self)
		self._taskEffect.hideEffWhileNotOnTop = nil

		settimer(2, self._onTweenFinish, self, false)
	end
end

function TaskCompeleteView:_onEffLoaded()
	AudioPlayerEx.instance:playEffect(30222)
end

function TaskCompeleteView:_stopEffect()
	if self._taskEffect then
		UIEffectManager.instance:stopEffect(self._taskEffect)

		self._taskEffect = nil
	end

	removetimer(self._onTweenFinish, self)
end

function TaskCompeleteView:onViewHideByLowerPriority()
	self:_stopEffect()
end

return TaskCompeleteView
