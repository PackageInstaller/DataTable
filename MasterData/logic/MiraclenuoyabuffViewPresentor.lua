-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclenuoya/view/MiraclenuoyabuffViewPresentor.lua

module("logic.extensions.miraclenuoya.view.MiraclenuoyabuffViewPresentor", package.seeall)

local MiraclenuoyabuffViewPresentor = class("MiraclenuoyabuffViewPresentor", ViewPresentor)

function MiraclenuoyabuffViewPresentor:ctor()
	MiraclenuoyabuffViewPresentor.super.ctor(self)
end

function MiraclenuoyabuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MiraclenuoyabuffViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/miraclenuoya/miraclenuoyabuffview.prefab"
	}
end

function MiraclenuoyabuffViewPresentor:buildViews()
	return {
		MiraclenuoyabuffView.New()
	}
end

return MiraclenuoyabuffViewPresentor
