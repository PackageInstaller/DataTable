-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/view/DivineKingNuoYaInfiniteFightChallengeViewPresentor.lua

module("logic.extensions.divinekingnuoya.view.DivineKingNuoYaInfiniteFightChallengeViewPresentor", package.seeall)

local DivineKingNuoYaInfiniteFightChallengeViewPresentor = class("DivineKingNuoYaInfiniteFightChallengeViewPresentor", ViewPresentor)

function DivineKingNuoYaInfiniteFightChallengeViewPresentor:ctor()
	DivineKingNuoYaInfiniteFightChallengeViewPresentor.super.ctor(self)
end

function DivineKingNuoYaInfiniteFightChallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingNuoYaInfiniteFightChallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingnuoya/divinekingnuoyainfinitefightchallengeview.prefab"
	}
end

function DivineKingNuoYaInfiniteFightChallengeViewPresentor:buildViews()
	return {
		DivineKingNuoYaInfiniteFightChallengeView.New()
	}
end

return DivineKingNuoYaInfiniteFightChallengeViewPresentor
