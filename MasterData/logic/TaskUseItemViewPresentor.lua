-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/TaskUseItemViewPresentor.lua

module("logic.extensions.task.view.TaskUseItemViewPresentor", package.seeall)

local TaskUseItemViewPresentor = class("TaskUseItemViewPresentor", ViewPresentor)

function TaskUseItemViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function TaskUseItemViewPresentor:dependWhatResources()
	return {
		"ui/views/task/taskuseitem.prefab"
	}
end

function TaskUseItemViewPresentor:buildViews()
	local views = {}
	local taskUseItemView = TaskUseItemView.New()

	table.insert(views, taskUseItemView)

	return views
end

return TaskUseItemViewPresentor
