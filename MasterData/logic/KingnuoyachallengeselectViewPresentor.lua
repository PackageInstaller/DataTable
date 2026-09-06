-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/view/KingnuoyachallengeselectViewPresentor.lua

module("logic.extensions.kingnuoya.view.KingnuoyachallengeselectViewPresentor", package.seeall)

local KingnuoyachallengeselectViewPresentor = class("KingnuoyachallengeselectViewPresentor", ViewPresentor)

function KingnuoyachallengeselectViewPresentor:ctor()
	KingnuoyachallengeselectViewPresentor.super.ctor(self)
end

function KingnuoyachallengeselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingnuoyachallengeselectViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/kingnuoya/kingnuoyachallengeselectview.prefab"
	}
end

function KingnuoyachallengeselectViewPresentor:buildViews()
	return {
		KingnuoyachallengeselectView.New()
	}
end

return KingnuoyachallengeselectViewPresentor
