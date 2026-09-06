-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelailisi/view/DivinelailisichallengelevelViewPresentor.lua

module("logic.extensions.divinelailisi.view.DivinelailisichallengelevelViewPresentor", package.seeall)

local DivinelailisichallengelevelViewPresentor = class("DivinelailisichallengelevelViewPresentor", ViewPresentor)

function DivinelailisichallengelevelViewPresentor:ctor()
	DivinelailisichallengelevelViewPresentor.super.ctor(self)
end

function DivinelailisichallengelevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinelailisichallengelevelViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinelailisi/divinelailisichallengelevelview.prefab"
	}
end

function DivinelailisichallengelevelViewPresentor:buildViews()
	return {
		DivinelailisichallengelevelView.New()
	}
end

return DivinelailisichallengelevelViewPresentor
