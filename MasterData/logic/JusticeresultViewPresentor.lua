-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/justice/view/JusticeresultViewPresentor.lua

module("logic.extensions.justice.view.JusticeresultViewPresentor", package.seeall)

local JusticeresultViewPresentor = class("JusticeresultViewPresentor", ViewPresentor)

function JusticeresultViewPresentor:ctor()
	JusticeresultViewPresentor.super.ctor(self)
end

function JusticeresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JusticeresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/justice/justiceresultview.prefab"
	}
end

function JusticeresultViewPresentor:buildViews()
	return {
		JusticeresultView.New()
	}
end

return JusticeresultViewPresentor
