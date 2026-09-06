-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikefmtpopupViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikefmtpopupViewPresentor", package.seeall)

local RoguelikefmtpopupViewPresentor = class("RoguelikefmtpopupViewPresentor", ViewPresentor)

function RoguelikefmtpopupViewPresentor:ctor()
	RoguelikefmtpopupViewPresentor.super.ctor(self)
end

function RoguelikefmtpopupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikefmtpopupViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikefmtpopupview.prefab"
	}
end

function RoguelikefmtpopupViewPresentor:buildViews()
	return {
		RoguelikefmtpopupView.New()
	}
end

return RoguelikefmtpopupViewPresentor
