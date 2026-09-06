-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyanorViewPresentor.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyanorViewPresentor", package.seeall)

local MiraclenuoyanorViewPresentor = class("MiraclenuoyanorViewPresentor", ViewPresentor)

function MiraclenuoyanorViewPresentor:ctor()
	MiraclenuoyanorViewPresentor.super.ctor(self)
end

function MiraclenuoyanorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclenuoyanorViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miraclenuoya/miraclenuoyanorview.prefab"
	}
end

function MiraclenuoyanorViewPresentor:buildViews()
	return {
		MiraclenuoyanorView.New()
	}
end

return MiraclenuoyanorViewPresentor
