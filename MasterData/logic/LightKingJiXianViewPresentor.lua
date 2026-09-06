-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingJiXianViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingJiXianViewPresentor", package.seeall)

local LightKingJiXianViewPresentor = class("LightKingJiXianViewPresentor", ViewPresentor)

function LightKingJiXianViewPresentor:ctor()
	LightKingJiXianViewPresentor.super.ctor(self)
end

function LightKingJiXianViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LightKingJiXianViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/lightking/lightkingjixianview.prefab"
	}
end

function LightKingJiXianViewPresentor:buildViews()
	return {
		LightKingJiXianView.New()
	}
end

return LightKingJiXianViewPresentor
