-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originholychallenge/view/OriginHolyChallengeStageViewPresentor.lua

module("logic.extensions.originholychallenge.view.OriginHolyChallengeStageViewPresentor", package.seeall)

local OriginHolyChallengeStageViewPresentor = class("OriginHolyChallengeStageViewPresentor", ViewPresentor)

function OriginHolyChallengeStageViewPresentor:ctor()
	OriginHolyChallengeStageViewPresentor.super.ctor(self)
end

function OriginHolyChallengeStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginHolyChallengeStageViewPresentor:dependWhatResources()
	return {
		"ui/views/originholychallenge/originholychallengestageview.prefab"
	}
end

function OriginHolyChallengeStageViewPresentor:buildViews()
	return {
		OriginHolyChallengeStageView.New()
	}
end

return OriginHolyChallengeStageViewPresentor
