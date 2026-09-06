-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyaresulttipsnorViewPresentor.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyaresulttipsnorViewPresentor", package.seeall)

local MiraclenuoyaresulttipsnorViewPresentor = class("MiraclenuoyaresulttipsnorViewPresentor", ViewPresentor)

function MiraclenuoyaresulttipsnorViewPresentor:ctor()
	MiraclenuoyaresulttipsnorViewPresentor.super.ctor(self)
end

function MiraclenuoyaresulttipsnorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclenuoyaresulttipsnorViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miraclenuoya/miraclenuoyaresulttipsnorview.prefab"
	}
end

function MiraclenuoyaresulttipsnorViewPresentor:buildViews()
	return {
		MiraclenuoyaresulttipsnorView.New()
	}
end

return MiraclenuoyaresulttipsnorViewPresentor
