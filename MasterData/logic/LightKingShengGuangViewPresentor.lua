-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingShengGuangViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingShengGuangViewPresentor", package.seeall)

local LightKingShengGuangViewPresentor = class("LightKingShengGuangViewPresentor", ViewPresentor)

function LightKingShengGuangViewPresentor:ctor()
	LightKingShengGuangViewPresentor.super.ctor(self)
end

function LightKingShengGuangViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightKingShengGuangViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightkingshengguangview.prefab"
	}
end

function LightKingShengGuangViewPresentor:buildViews()
	return {
		LightKingShengGuangView.New()
	}
end

return LightKingShengGuangViewPresentor
