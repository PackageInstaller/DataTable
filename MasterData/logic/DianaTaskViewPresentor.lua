-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/diana/DianaTaskViewPresentor.lua

module("logic.extensions.lailisi.view.diana.DianaTaskViewPresentor", package.seeall)

local DianaTaskViewPresentor = class("DianaTaskViewPresentor", ViewPresentor)

function DianaTaskViewPresentor:ctor()
	DianaTaskViewPresentor.super.ctor(self)
end

function DianaTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DianaTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/diana/dianataskview.prefab"
	}
end

function DianaTaskViewPresentor:buildViews()
	return {
		DianaTaskView.New()
	}
end

return DianaTaskViewPresentor
