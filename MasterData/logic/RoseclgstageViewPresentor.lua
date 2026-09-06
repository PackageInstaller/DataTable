-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/view/RoseclgstageViewPresentor.lua

module("logic.extensions.roseclg.view.RoseclgstageViewPresentor", package.seeall)

local RoseclgstageViewPresentor = class("RoseclgstageViewPresentor", ViewPresentor)

function RoseclgstageViewPresentor:ctor()
	RoseclgstageViewPresentor.super.ctor(self)
end

function RoseclgstageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoseclgstageViewPresentor:dependWhatResources()
	return {
		"ui/views/roseclg/roseclgstageview.prefab"
	}
end

function RoseclgstageViewPresentor:buildViews()
	return {
		RoseclgstageView.New()
	}
end

return RoseclgstageViewPresentor
