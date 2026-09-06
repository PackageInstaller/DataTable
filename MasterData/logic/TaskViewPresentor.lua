-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskViewPresentor.lua

module("logic.extensions.task.view.TaskViewPresentor", package.seeall)

local TaskViewPresentor = class("TaskViewPresentor", ViewPresentor)

function TaskViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function TaskViewPresentor:dependWhatResources()
	return {
		"ui/views/task/taskview.prefab"
	}
end

function TaskViewPresentor:buildViews()
	local views = {}
	local taskView = TaskView.New()

	table.insert(views, taskView)

	return views
end

return TaskViewPresentor
