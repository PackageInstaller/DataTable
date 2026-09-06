-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/KdChallengeStageViewPresentor.lua

module("logic.extensions.kingdragonchallenge.view.KdChallengeStageViewPresentor", package.seeall)

local KdChallengeStageViewPresentor = class("KdChallengeStageViewPresentor", ViewPresentor)

function KdChallengeStageViewPresentor:ctor()
	KdChallengeStageViewPresentor.super.ctor(self)
end

function KdChallengeStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KdChallengeStageViewPresentor:dependWhatResources()
	return {
		"ui/views/kingdragonchallenge/kdchallengestageview.prefab"
	}
end

function KdChallengeStageViewPresentor:buildViews()
	return {
		KdChallengeStageView.New()
	}
end

return KdChallengeStageViewPresentor
