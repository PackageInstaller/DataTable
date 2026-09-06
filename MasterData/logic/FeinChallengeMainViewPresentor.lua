-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/FeinChallengeMainViewPresentor.lua

module("logic.extensions.moonking.view.FeinChallengeMainViewPresentor", package.seeall)

local FeinChallengeMainViewPresentor = class("FeinChallengeMainViewPresentor", ViewWithGuidePresentor)

function FeinChallengeMainViewPresentor:ctor()
	FeinChallengeMainViewPresentor.super.ctor(self)
end

function FeinChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FeinChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/moonking/feinchallengemainview.prefab"
	}
end

function FeinChallengeMainViewPresentor:buildViews()
	return {
		FeinChallengeMainView.New()
	}
end

return FeinChallengeMainViewPresentor
