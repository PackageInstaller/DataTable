-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanshenglong/view/CiyuanshenglongchallengefightViewPresentor.lua

module("logic.extensions.ciyuanshenglong.view.CiyuanshenglongchallengefightViewPresentor", package.seeall)

local CiyuanshenglongchallengefightViewPresentor = class("CiyuanshenglongchallengefightViewPresentor", ViewPresentor)

function CiyuanshenglongchallengefightViewPresentor:ctor()
	CiyuanshenglongchallengefightViewPresentor.super.ctor(self)
end

function CiyuanshenglongchallengefightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CiyuanshenglongchallengefightViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/ciyuanshenglong/ciyuanshenglongchallengefightview.prefab"
	}
end

function CiyuanshenglongchallengefightViewPresentor:buildViews()
	return {
		CiyuanshenglongchallengefightView.New()
	}
end

return CiyuanshenglongchallengefightViewPresentor
