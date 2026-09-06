-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeBossViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeBossViewPresentor", package.seeall)

local KdChallengeBossViewPresentor = class("KdChallengeBossViewPresentor", ViewPresentor)

function KdChallengeBossViewPresentor:ctor()
	KdChallengeBossViewPresentor.super.ctor(self)
end

function KdChallengeBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KdChallengeBossViewPresentor:dependWhatResources()
	return {
		"ui/views/kingdragonchallenge/kdchallengebossview.prefab"
	}
end

function KdChallengeBossViewPresentor:buildViews()
	return {
		KdChallengeBossView.New()
	}
end

return KdChallengeBossViewPresentor
