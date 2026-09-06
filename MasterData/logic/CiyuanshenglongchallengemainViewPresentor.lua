-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/view/CiyuanshenglongchallengemainViewPresentor.lua

module("logic.extensions.ciyuanshenglong.view.CiyuanshenglongchallengemainViewPresentor", package.seeall)

local CiyuanshenglongchallengemainViewPresentor = class("CiyuanshenglongchallengemainViewPresentor", ViewPresentor)

function CiyuanshenglongchallengemainViewPresentor:ctor()
	CiyuanshenglongchallengemainViewPresentor.super.ctor(self)
end

function CiyuanshenglongchallengemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CiyuanshenglongchallengemainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/ciyuanshenglong/ciyuanshenglongchallengemainview.prefab"
	}
end

function CiyuanshenglongchallengemainViewPresentor:buildViews()
	return {
		CiyuanshenglongchallengemainView.New()
	}
end

return CiyuanshenglongchallengemainViewPresentor
