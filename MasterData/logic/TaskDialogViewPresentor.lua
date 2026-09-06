-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskDialogViewPresentor.lua

module("logic.extensions.task.view.TaskDialogViewPresentor", package.seeall)

local TaskDialogViewPresentor = class("TaskDialogViewPresentor", ViewPresentor)

function TaskDialogViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function TaskDialogViewPresentor:dependWhatResources()
	return {
		"ui/views/task/taskdialog.prefab"
	}
end

function TaskDialogViewPresentor:buildViews()
	local views = {}
	local taskDialogView = TaskDialogView.New()

	table.insert(views, taskDialogView)

	return views
end

return TaskDialogViewPresentor
