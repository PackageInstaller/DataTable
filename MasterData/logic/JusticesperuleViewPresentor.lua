-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/justice/view/JusticesperuleViewPresentor.lua

module("logic.extensions.justice.view.JusticesperuleViewPresentor", package.seeall)

local JusticesperuleViewPresentor = class("JusticesperuleViewPresentor", ViewPresentor)

function JusticesperuleViewPresentor:ctor()
	JusticesperuleViewPresentor.super.ctor(self)
end

function JusticesperuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JusticesperuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/justice/justicesperuleview.prefab"
	}
end

function JusticesperuleViewPresentor:buildViews()
	return {
		JusticesperuleView.New()
	}
end

return JusticesperuleViewPresentor
