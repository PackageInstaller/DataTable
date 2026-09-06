-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originholychallenge/view/OriginHolyChallengeMainViewPresentor.lua

module("logic.extensions.originholychallenge.view.OriginHolyChallengeMainViewPresentor", package.seeall)

local OriginHolyChallengeMainViewPresentor = class("OriginHolyChallengeMainViewPresentor", ViewPresentor)

function OriginHolyChallengeMainViewPresentor:ctor()
	OriginHolyChallengeMainViewPresentor.super.ctor(self)
end

function OriginHolyChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginHolyChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originholychallenge/originholychallengemainview.prefab"
	}
end

function OriginHolyChallengeMainViewPresentor:buildViews()
	return {
		OriginHolyChallengeMainView.New()
	}
end

return OriginHolyChallengeMainViewPresentor
