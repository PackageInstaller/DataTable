-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingYaoShiViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingYaoShiViewPresentor", package.seeall)

local LightKingYaoShiViewPresentor = class("LightKingYaoShiViewPresentor", ViewPresentor)

function LightKingYaoShiViewPresentor:ctor()
	LightKingYaoShiViewPresentor.super.ctor(self)
end

function LightKingYaoShiViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightKingYaoShiViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightkingyaoshiview.prefab"
	}
end

function LightKingYaoShiViewPresentor:buildViews()
	return {
		LightKingYaoShiView.New()
	}
end

return LightKingYaoShiViewPresentor
