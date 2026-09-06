-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/view/StarGodChallengeExtViewPresentor.lua

module("logic.extensions.stargodchallenge.view.StarGodChallengeExtViewPresentor", package.seeall)

local StarGodChallengeExtViewPresentor = class("StarGodChallengeExtViewPresentor", ViewPresentor)

function StarGodChallengeExtViewPresentor:ctor()
	StarGodChallengeExtViewPresentor.super.ctor(self)
end

function StarGodChallengeExtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarGodChallengeExtViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripecopy/holystripecopyaddtipview.prefab"
	}
end

function StarGodChallengeExtViewPresentor:buildViews()
	return {
		StarGodChallengeExtView.New()
	}
end

return StarGodChallengeExtViewPresentor
