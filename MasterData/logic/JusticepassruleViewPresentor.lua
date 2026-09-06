-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/justice/view/JusticepassruleViewPresentor.lua

module("logic.extensions.justice.view.JusticepassruleViewPresentor", package.seeall)

local JusticepassruleViewPresentor = class("JusticepassruleViewPresentor", ViewPresentor)

function JusticepassruleViewPresentor:ctor()
	JusticepassruleViewPresentor.super.ctor(self)
end

function JusticepassruleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JusticepassruleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/justice/justicepassruleview.prefab"
	}
end

function JusticepassruleViewPresentor:buildViews()
	return {
		JusticepassruleView.New()
	}
end

return JusticepassruleViewPresentor
