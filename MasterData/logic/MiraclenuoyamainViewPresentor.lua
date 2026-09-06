-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyamainViewPresentor.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyamainViewPresentor", package.seeall)

local MiraclenuoyamainViewPresentor = class("MiraclenuoyamainViewPresentor", ViewPresentor)

function MiraclenuoyamainViewPresentor:ctor()
	MiraclenuoyamainViewPresentor.super.ctor(self)
end

function MiraclenuoyamainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclenuoyamainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miraclenuoya/miraclenuoyamainview.prefab"
	}
end

function MiraclenuoyamainViewPresentor:buildViews()
	return {
		MiraclenuoyamainView.New()
	}
end

return MiraclenuoyamainViewPresentor
