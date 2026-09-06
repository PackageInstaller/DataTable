-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/view/KingnuoyachallengeViewPresentor.lua

module("logic.extensions.kingnuoya.view.KingnuoyachallengeViewPresentor", package.seeall)

local KingnuoyachallengeViewPresentor = class("KingnuoyachallengeViewPresentor", ViewPresentor)

function KingnuoyachallengeViewPresentor:ctor()
	KingnuoyachallengeViewPresentor.super.ctor(self)
end

function KingnuoyachallengeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingnuoyachallengeViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/kingnuoya/kingnuoyachallengeview.prefab"
	}
end

function KingnuoyachallengeViewPresentor:buildViews()
	return {
		KingnuoyachallengeView.New()
	}
end

return KingnuoyachallengeViewPresentor
