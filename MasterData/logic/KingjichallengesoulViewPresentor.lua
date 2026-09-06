-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjichallengesoulViewPresentor.lua

module("logic.extensions.kingjichallenge.view.KingjichallengesoulViewPresentor", package.seeall)

local KingjichallengesoulViewPresentor = class("KingjichallengesoulViewPresentor", ViewPresentor)

function KingjichallengesoulViewPresentor:ctor()
	KingjichallengesoulViewPresentor.super.ctor(self)
end

function KingjichallengesoulViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingjichallengesoulViewPresentor:dependWhatResources()
	return {
		"ui/views/kingjichallenge/kingjichallengesoulview.prefab"
	}
end

function KingjichallengesoulViewPresentor:buildViews()
	return {
		KingjichallengesoulView.New()
	}
end

return KingjichallengesoulViewPresentor
