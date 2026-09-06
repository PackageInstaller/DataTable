-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskCompeleteViewPresentor.lua

module("logic.extensions.task.view.TaskCompeleteViewPresentor", package.seeall)

local TaskCompeleteViewPresentor = class("TaskCompeleteViewPresentor", ViewWithGuidePresentor)

function TaskCompeleteViewPresentor:ctor()
	TaskCompeleteViewPresentor.super.ctor(self)

	self.priority = ViewPriorityMgr.TaskCompeleteViewPriority
end

function TaskCompeleteViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function TaskCompeleteViewPresentor:dependWhatResources()
	return {
		"ui/views/task/task_compelete.prefab"
	}
end

function TaskCompeleteViewPresentor:buildViews()
	local views = {}
	local taskCompeleteView = TaskCompeleteView.New()

	table.insert(views, taskCompeleteView)

	return views
end

function TaskCompeleteViewPresentor:_onViewShowByHigherPriority()
	local views = self._views

	views[1]:onViewShowByHigherPriority()
end

function TaskCompeleteViewPresentor:_onViewHideByLowerPriority()
	local views = self._views

	views[1]:onViewHideByLowerPriority()
end

return TaskCompeleteViewPresentor
