-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/view/CollectViewPresentor.lua

module("logic.extensions.task.view.CollectViewPresentor", package.seeall)

local CollectViewPresentor = class("CollectViewPresentor", ViewPresentor)

function CollectViewPresentor:attachToWhichRoot()
	return ViewRootType.HudTop
end

function CollectViewPresentor:dependWhatResources()
	return {
		"ui/views/task/taskcollect.prefab"
	}
end

function CollectViewPresentor:buildViews()
	local views = {}
	local collectView = CollectView.New()

	table.insert(views, collectView)

	return views
end

return CollectViewPresentor
