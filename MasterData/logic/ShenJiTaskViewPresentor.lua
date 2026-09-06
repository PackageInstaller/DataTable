-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiTaskViewPresentor.lua

module("logic.extensions.shenjichallenge.view.ShenJiTaskViewPresentor", package.seeall)

local ShenJiTaskViewPresentor = class("ShenJiTaskViewPresentor", ViewPresentor)

function ShenJiTaskViewPresentor:ctor()
	ShenJiTaskViewPresentor.super.ctor(self)
end

function ShenJiTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenJiTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/shenjitaskview.prefab"
	}
end

function ShenJiTaskViewPresentor:buildViews()
	return {
		ShenJiTaskView.New()
	}
end

return ShenJiTaskViewPresentor
