-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/ChallengePassViewPresentor.lua

module("logic.extensions.common.view.ChallengePassViewPresentor", package.seeall)

local ChallengePassViewPresentor = class("ChallengePassViewPresentor", ViewPresentor)

function ChallengePassViewPresentor:ctor()
	ChallengePassViewPresentor.super.ctor(self)
end

function ChallengePassViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChallengePassViewPresentor:dependWhatResources()
	return {
		"ui/views/common/challengepassview.prefab"
	}
end

function ChallengePassViewPresentor:buildViews()
	return {
		ChallengePassView.New()
	}
end

return ChallengePassViewPresentor
