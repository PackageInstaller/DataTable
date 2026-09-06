-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darknessspring/view/DarknessSpringTaskViewPresentor.lua

module("logic.extensions.darknessspring.view.DarknessSpringTaskViewPresentor", package.seeall)

local DarknessSpringTaskViewPresentor = class("DarknessSpringTaskViewPresentor", ViewPresentor)

function DarknessSpringTaskViewPresentor:ctor()
	DarknessSpringTaskViewPresentor.super.ctor(self)
end

function DarknessSpringTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DarknessSpringTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/darknessspring/darknessspringtaskview.prefab"
	}
end

function DarknessSpringTaskViewPresentor:buildViews()
	return {
		DarknessSpringTaskView.New()
	}
end

return DarknessSpringTaskViewPresentor
