-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelailisi/view/DivinelailisichallengemainViewPresentor.lua

module("logic.extensions.divinelailisi.view.DivinelailisichallengemainViewPresentor", package.seeall)

local DivinelailisichallengemainViewPresentor = class("DivinelailisichallengemainViewPresentor", ViewPresentor)

function DivinelailisichallengemainViewPresentor:ctor()
	DivinelailisichallengemainViewPresentor.super.ctor(self)
end

function DivinelailisichallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinelailisichallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinelailisi/divinelailisichallengemainview.prefab"
	}
end

function DivinelailisichallengemainViewPresentor:buildViews()
	return {
		DivinelailisichallengemainView.New()
	}
end

return DivinelailisichallengemainViewPresentor
