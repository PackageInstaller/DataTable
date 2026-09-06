-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/view/DualdragonallchallengeViewPresentor.lua

module("logic.extensions.dualdragonchallenge.view.DualdragonallchallengeViewPresentor", package.seeall)

local DualdragonallchallengeViewPresentor = class("DualdragonallchallengeViewPresentor", ViewPresentor)

function DualdragonallchallengeViewPresentor:ctor()
	DualdragonallchallengeViewPresentor.super.ctor(self)
end

function DualdragonallchallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DualdragonallchallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/dualdragonchallenge/dualdragonallchallengeview.prefab"
	}
end

function DualdragonallchallengeViewPresentor:buildViews()
	return {
		DualdragonallchallengeView.New()
	}
end

return DualdragonallchallengeViewPresentor
