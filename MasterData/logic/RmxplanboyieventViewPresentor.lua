-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanboyieventViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanboyieventViewPresentor", package.seeall)

local RmxplanboyieventViewPresentor = class("RmxplanboyieventViewPresentor", ViewPresentor)

function RmxplanboyieventViewPresentor:ctor()
	RmxplanboyieventViewPresentor.super.ctor(self)
end

function RmxplanboyieventViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RmxplanboyieventViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanboyieventview.prefab"
	}
end

function RmxplanboyieventViewPresentor:buildViews()
	return {
		RmxplanboyieventView.New()
	}
end

return RmxplanboyieventViewPresentor
