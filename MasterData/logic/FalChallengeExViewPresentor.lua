-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/landlords/view/FalChallengeExViewPresentor.lua

module("logic.extensions.landlords.view.FalChallengeExViewPresentor", package.seeall)

local FalChallengeExViewPresentor = class("FalChallengeExViewPresentor", ViewPresentor)

function FalChallengeExViewPresentor:ctor()
	FalChallengeExViewPresentor.super.ctor(self)
end

function FalChallengeExViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FalChallengeExViewPresentor:dependWhatResources()
	return {
		"ui/views/landlords/falchallengeexview.prefab"
	}
end

function FalChallengeExViewPresentor:buildViews()
	return {
		FalChallengeExView.New()
	}
end

return FalChallengeExViewPresentor
