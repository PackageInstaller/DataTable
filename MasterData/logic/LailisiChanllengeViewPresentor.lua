-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lailisi/view/LailisiChanllengeViewPresentor.lua

module("logic.extensions.lailisi.view.LailisiChanllengeViewPresentor", package.seeall)

local LailisiChanllengeViewPresentor = class("LailisiChanllengeViewPresentor", ViewPresentor)

function LailisiChanllengeViewPresentor:ctor()
	LailisiChanllengeViewPresentor.super.ctor(self)
end

function LailisiChanllengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LailisiChanllengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lailisi/lailisichanllengeview.prefab"
	}
end

function LailisiChanllengeViewPresentor:buildViews()
	return {
		LailisiChanllengeView.New()
	}
end

return LailisiChanllengeViewPresentor
