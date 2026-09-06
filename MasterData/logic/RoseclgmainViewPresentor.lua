-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/view/RoseclgmainViewPresentor.lua

module("logic.extensions.roseclg.view.RoseclgmainViewPresentor", package.seeall)

local RoseclgmainViewPresentor = class("RoseclgmainViewPresentor", ViewPresentor)

function RoseclgmainViewPresentor:ctor()
	RoseclgmainViewPresentor.super.ctor(self)
end

function RoseclgmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoseclgmainViewPresentor:dependWhatResources()
	return {
		"ui/views/roseclg/roseclgmainview.prefab"
	}
end

function RoseclgmainViewPresentor:buildViews()
	return {
		RoseclgmainView.New()
	}
end

return RoseclgmainViewPresentor
