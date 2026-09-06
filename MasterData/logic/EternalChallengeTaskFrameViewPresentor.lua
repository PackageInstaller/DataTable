-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/eternalchallenge/EternalChallengeTaskFrameViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.eternalchallenge.EternalChallengeTaskFrameViewPresentor", package.seeall)

local EternalChallengeTaskFrameViewPresentor = class("EternalChallengeTaskFrameViewPresentor", ViewPresentor)

function EternalChallengeTaskFrameViewPresentor:ctor()
	EternalChallengeTaskFrameViewPresentor.super.ctor(self)
end

function EternalChallengeTaskFrameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalChallengeTaskFrameViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/eternalchallenge/eternalchallengetaskframeview.prefab"
	}
end

function EternalChallengeTaskFrameViewPresentor:buildViews()
	return {
		EternalChallengeTaskFrameView.New()
	}
end

return EternalChallengeTaskFrameViewPresentor
