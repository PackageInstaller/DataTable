-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalkingsignin/view/SurvivalKingSignInViewPresentor.lua

module("logic.extensions.survivalkingsignin.view.SurvivalKingSignInViewPresentor", package.seeall)

local SurvivalKingSignInViewPresentor = class("SurvivalKingSignInViewPresentor", ViewPresentor)

function SurvivalKingSignInViewPresentor:ctor()
	SurvivalKingSignInViewPresentor.super.ctor(self)
end

function SurvivalKingSignInViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SurvivalKingSignInViewPresentor:dependWhatResources()
	return {
		"ui/views/survivalkingsignin/survivalkingsigninview.prefab"
	}
end

function SurvivalKingSignInViewPresentor:buildViews()
	return {
		SurvivalKingSignInView.New()
	}
end

return SurvivalKingSignInViewPresentor
