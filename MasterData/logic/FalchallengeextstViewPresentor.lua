-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalchallengeextstViewPresentor.lua

module("logic.extensions.landlords.view.FalchallengeextstViewPresentor", package.seeall)

local FalchallengeextstViewPresentor = class("FalchallengeextstViewPresentor", ViewPresentor)

function FalchallengeextstViewPresentor:ctor()
	FalchallengeextstViewPresentor.super.ctor(self)
end

function FalchallengeextstViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalchallengeextstViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falchallengeextstview.prefab"
	}
end

function FalchallengeextstViewPresentor:buildViews()
	return {
		FalchallengeextstView.New()
	}
end

return FalchallengeextstViewPresentor
