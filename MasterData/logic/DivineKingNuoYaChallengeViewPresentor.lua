-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/view/DivineKingNuoYaChallengeViewPresentor.lua

module("logic.extensions.divinekingnuoya.view.DivineKingNuoYaChallengeViewPresentor", package.seeall)

local DivineKingNuoYaChallengeViewPresentor = class("DivineKingNuoYaChallengeViewPresentor", ViewPresentor)

function DivineKingNuoYaChallengeViewPresentor:ctor()
	DivineKingNuoYaChallengeViewPresentor.super.ctor(self)
end

function DivineKingNuoYaChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingNuoYaChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingnuoya/divinekingnuoyachallengeview.prefab"
	}
end

function DivineKingNuoYaChallengeViewPresentor:buildViews()
	return {
		DivineKingNuoYaChallengeView.New()
	}
end

return DivineKingNuoYaChallengeViewPresentor
