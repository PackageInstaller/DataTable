-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stargodchallenge/view/StarGodChallengeMainViewPresentor.lua

module("logic.extensions.stargodchallenge.view.StarGodChallengeMainViewPresentor", package.seeall)

local StarGodChallengeMainViewPresentor = class("StarGodChallengeMainViewPresentor", ViewPresentor)

function StarGodChallengeMainViewPresentor:ctor()
	StarGodChallengeMainViewPresentor.super.ctor(self)
end

function StarGodChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarGodChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/stargodchallenge/stargodchallengemainview.prefab"
	}
end

function StarGodChallengeMainViewPresentor:buildViews()
	return {
		StarGodChallengeMainView.New()
	}
end

return StarGodChallengeMainViewPresentor
