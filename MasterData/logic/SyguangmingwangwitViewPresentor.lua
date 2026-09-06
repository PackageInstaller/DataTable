-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/syguangmingwang/SyguangmingwangwitViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.syguangmingwang.SyguangmingwangwitViewPresentor", package.seeall)

local SyguangmingwangwitViewPresentor = class("SyguangmingwangwitViewPresentor", ViewPresentor)

function SyguangmingwangwitViewPresentor:ctor()
	SyguangmingwangwitViewPresentor.super.ctor(self)
end

function SyguangmingwangwitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SyguangmingwangwitViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syguangmingwang/syguangmingwangwitview.prefab"
	}
end

function SyguangmingwangwitViewPresentor:buildViews()
	return {
		SyguangmingwangwitView.New()
	}
end

return SyguangmingwangwitViewPresentor
