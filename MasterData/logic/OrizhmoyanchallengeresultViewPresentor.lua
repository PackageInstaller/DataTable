-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/copy/OrizhmoyanchallengeresultViewPresentor.lua

module("logic.extensions.fantian.view.copy.OrizhmoyanchallengeresultViewPresentor", package.seeall)

local OrizhmoyanchallengeresultViewPresentor = class("OrizhmoyanchallengeresultViewPresentor", ViewPresentor)

function OrizhmoyanchallengeresultViewPresentor:ctor()
	OrizhmoyanchallengeresultViewPresentor.super.ctor(self)
end

function OrizhmoyanchallengeresultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OrizhmoyanchallengeresultViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/fantian/copy/orizhmoyanchallengeresultview.prefab"
	}
end

function OrizhmoyanchallengeresultViewPresentor:buildViews()
	return {
		OrizhmoyanchallengeresultView.New()
	}
end

return OrizhmoyanchallengeresultViewPresentor
