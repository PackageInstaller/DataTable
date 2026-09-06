-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/FbbchallengemainViewPresentor.lua

module("logic.extensions.fbbchallenge.view.FbbchallengemainViewPresentor", package.seeall)

local FbbchallengemainViewPresentor = class("FbbchallengemainViewPresentor", ViewPresentor)

function FbbchallengemainViewPresentor:ctor()
	FbbchallengemainViewPresentor.super.ctor(self)
end

function FbbchallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FbbchallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/fbbchallenge/fbbchallengemainview.prefab"
	}
end

function FbbchallengemainViewPresentor:buildViews()
	return {
		FbbchallengemainView.New()
	}
end

return FbbchallengemainViewPresentor
