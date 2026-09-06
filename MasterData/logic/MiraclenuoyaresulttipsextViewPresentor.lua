-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyaresulttipsextViewPresentor.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyaresulttipsextViewPresentor", package.seeall)

local MiraclenuoyaresulttipsextViewPresentor = class("MiraclenuoyaresulttipsextViewPresentor", ViewPresentor)

function MiraclenuoyaresulttipsextViewPresentor:ctor()
	MiraclenuoyaresulttipsextViewPresentor.super.ctor(self)
end

function MiraclenuoyaresulttipsextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclenuoyaresulttipsextViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miraclenuoya/miraclenuoyaresulttipsextview.prefab"
	}
end

function MiraclenuoyaresulttipsextViewPresentor:buildViews()
	return {
		MiraclenuoyaresulttipsextView.New()
	}
end

return MiraclenuoyaresulttipsextViewPresentor
