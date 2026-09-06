-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/diana/DianaChanllengeViewPresentor.lua

module("logic.extensions.lailisi.view.diana.DianaChanllengeViewPresentor", package.seeall)

local DianaChanllengeViewPresentor = class("DianaChanllengeViewPresentor", ViewPresentor)

function DianaChanllengeViewPresentor:ctor()
	DianaChanllengeViewPresentor.super.ctor(self)
end

function DianaChanllengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DianaChanllengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/diana/dianachanllengeview.prefab"
	}
end

function DianaChanllengeViewPresentor:buildViews()
	return {
		DianaChanllengeView.New()
	}
end

return DianaChanllengeViewPresentor
