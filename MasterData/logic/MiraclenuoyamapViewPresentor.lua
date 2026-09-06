-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyamapViewPresentor.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyamapViewPresentor", package.seeall)

local MiraclenuoyamapViewPresentor = class("MiraclenuoyamapViewPresentor", ViewPresentor)

function MiraclenuoyamapViewPresentor:ctor()
	MiraclenuoyamapViewPresentor.super.ctor(self)
end

function MiraclenuoyamapViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclenuoyamapViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miraclenuoya/miraclenuoyamapview.prefab"
	}
end

function MiraclenuoyamapViewPresentor:buildViews()
	return {
		MiraclenuoyamapView.New()
	}
end

return MiraclenuoyamapViewPresentor
