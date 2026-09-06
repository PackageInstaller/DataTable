-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeMainViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeMainViewPresentor", package.seeall)

local KdChallengeMainViewPresentor = class("KdChallengeMainViewPresentor", ViewPresentor)

function KdChallengeMainViewPresentor:ctor()
	KdChallengeMainViewPresentor.super.ctor(self)
end

function KdChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KdChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingdragonchallenge/kdchallengemainview.prefab"
	}
end

function KdChallengeMainViewPresentor:buildViews()
	return {
		KdChallengeMainView.New()
	}
end

return KdChallengeMainViewPresentor
