-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalchallenge/view/EternalChallengeMainViewPresentor.lua

module("logic.extensions.eternalchallenge.view.EternalChallengeMainViewPresentor", package.seeall)

local EternalChallengeMainViewPresentor = class("EternalChallengeMainViewPresentor", ViewPresentor)

function EternalChallengeMainViewPresentor:ctor()
	EternalChallengeMainViewPresentor.super.ctor(self)
end

function EternalChallengeMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalChallengeMainViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalchallenge/eternalchallengemainview.prefab"
	}
end

function EternalChallengeMainViewPresentor:buildViews()
	return {
		EternalChallengeMainView.New()
	}
end

return EternalChallengeMainViewPresentor
