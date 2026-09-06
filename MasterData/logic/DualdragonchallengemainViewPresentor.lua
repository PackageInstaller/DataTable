-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/view/DualdragonchallengemainViewPresentor.lua

module("logic.extensions.dualdragonchallenge.view.DualdragonchallengemainViewPresentor", package.seeall)

local DualdragonchallengemainViewPresentor = class("DualdragonchallengemainViewPresentor", ViewPresentor)

function DualdragonchallengemainViewPresentor:ctor()
	DualdragonchallengemainViewPresentor.super.ctor(self)
end

function DualdragonchallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DualdragonchallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/dualdragonchallenge/dualdragonchallengemainview.prefab"
	}
end

function DualdragonchallengemainViewPresentor:buildViews()
	return {
		DualdragonchallengemainView.New()
	}
end

return DualdragonchallengemainViewPresentor
