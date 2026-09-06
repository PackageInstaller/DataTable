-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/view/CiyuanshenglongchallengerankViewPresentor.lua

module("logic.extensions.ciyuanshenglong.view.CiyuanshenglongchallengerankViewPresentor", package.seeall)

local CiyuanshenglongchallengerankViewPresentor = class("CiyuanshenglongchallengerankViewPresentor", ViewPresentor)

function CiyuanshenglongchallengerankViewPresentor:ctor()
	CiyuanshenglongchallengerankViewPresentor.super.ctor(self)
end

function CiyuanshenglongchallengerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CiyuanshenglongchallengerankViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/ciyuanshenglong/ciyuanshenglongchallengerankview.prefab"
	}
end

function CiyuanshenglongchallengerankViewPresentor:buildViews()
	return {
		CiyuanshenglongchallengerankView.New()
	}
end

return CiyuanshenglongchallengerankViewPresentor
