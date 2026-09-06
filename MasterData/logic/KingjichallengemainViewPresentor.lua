-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingjichallenge/view/KingjichallengemainViewPresentor.lua

module("logic.extensions.kingjichallenge.view.KingjichallengemainViewPresentor", package.seeall)

local KingjichallengemainViewPresentor = class("KingjichallengemainViewPresentor", ViewPresentor)

function KingjichallengemainViewPresentor:ctor()
	KingjichallengemainViewPresentor.super.ctor(self)
end

function KingjichallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function KingjichallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/kingjichallenge/kingjichallengemainview.prefab"
	}
end

function KingjichallengemainViewPresentor:buildViews()
	return {
		KingjichallengemainView.New()
	}
end

return KingjichallengemainViewPresentor
