-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/diamondtask/view/DiamondTaskViewPresentor.lua

module("logic.extensions.diamondtask.view.DiamondTaskViewPresentor", package.seeall)

local DiamondTaskViewPresentor = class("DiamondTaskViewPresentor", ViewPresentor)

function DiamondTaskViewPresentor:ctor()
	DiamondTaskViewPresentor.super.ctor(self)
end

function DiamondTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DiamondTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/diamondtask/diamondtaskview.prefab"
	}
end

function DiamondTaskViewPresentor:buildViews()
	return {
		DiamondTaskView.New()
	}
end

return DiamondTaskViewPresentor
