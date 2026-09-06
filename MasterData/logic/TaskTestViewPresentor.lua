-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskTestViewPresentor.lua

module("logic.extensions.task.view.TaskTestViewPresentor", package.seeall)

local TaskTestViewPresentor = class("TaskTestViewPresentor", ViewPresentor)

function TaskTestViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function TaskTestViewPresentor:dependWhatResources()
	return {
		"ui/views/task/tasktestview.prefab"
	}
end

function TaskTestViewPresentor:buildViews()
	local views = {}
	local taskTestView = TaskTestView.New()

	table.insert(views, taskTestView)

	return views
end

return TaskTestViewPresentor
