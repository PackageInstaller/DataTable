-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/view/ChallengewinresultViewPresentor.lua

module("logic.extensions.twindragonchallenge.view.ChallengewinresultViewPresentor", package.seeall)

local ChallengewinresultViewPresentor = class("ChallengewinresultViewPresentor", ViewPresentor)

function ChallengewinresultViewPresentor:ctor()
	ChallengewinresultViewPresentor.super.ctor(self)
end

function ChallengewinresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChallengewinresultViewPresentor:dependWhatResources()
	return {
		"ui/views/twindragonchallenge/challengewinresultview.prefab"
	}
end

function ChallengewinresultViewPresentor:buildViews()
	return {
		ChallengewinresultView.New()
	}
end

return ChallengewinresultViewPresentor
