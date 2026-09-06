-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyatipsViewPresentor.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyatipsViewPresentor", package.seeall)

local MiraclenuoyatipsViewPresentor = class("MiraclenuoyatipsViewPresentor", ViewPresentor)

function MiraclenuoyatipsViewPresentor:ctor()
	MiraclenuoyatipsViewPresentor.super.ctor(self)
end

function MiraclenuoyatipsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclenuoyatipsViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miraclenuoya/miraclenuoyatipsview.prefab"
	}
end

function MiraclenuoyatipsViewPresentor:buildViews()
	return {
		MiraclenuoyatipsView.New()
	}
end

return MiraclenuoyatipsViewPresentor
