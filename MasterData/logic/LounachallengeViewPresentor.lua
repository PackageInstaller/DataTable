-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/louna/LounachallengeViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.louna.LounachallengeViewPresentor", package.seeall)

local LounachallengeViewPresentor = class("LounachallengeViewPresentor", ViewPresentor)

function LounachallengeViewPresentor:ctor()
	LounachallengeViewPresentor.super.ctor(self)
end

function LounachallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LounachallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/louna/lounachallengeview.prefab"
	}
end

function LounachallengeViewPresentor:buildViews()
	return {
		LounachallengeView.New()
	}
end

return LounachallengeViewPresentor
