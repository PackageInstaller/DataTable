-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunchallengemainViewPresentor.lua

module("logic.extensions.divinekunlun.view.DivinekunlunchallengemainViewPresentor", package.seeall)

local DivinekunlunchallengemainViewPresentor = class("DivinekunlunchallengemainViewPresentor", ViewPresentor)

function DivinekunlunchallengemainViewPresentor:ctor()
	DivinekunlunchallengemainViewPresentor.super.ctor(self)
end

function DivinekunlunchallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinekunlunchallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/divinekunlun/divinekunlunchallengemainview.prefab"
	}
end

function DivinekunlunchallengemainViewPresentor:buildViews()
	return {
		DivinekunlunchallengemainView.New()
	}
end

return DivinekunlunchallengemainViewPresentor
