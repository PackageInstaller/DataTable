-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/syguangmingwang/SyguangmingwangmainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.syguangmingwang.SyguangmingwangmainViewPresentor", package.seeall)

local SyguangmingwangmainViewPresentor = class("SyguangmingwangmainViewPresentor", ViewPresentor)

function SyguangmingwangmainViewPresentor:ctor()
	SyguangmingwangmainViewPresentor.super.ctor(self)
end

function SyguangmingwangmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SyguangmingwangmainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syguangmingwang/syguangmingwangmainview.prefab"
	}
end

function SyguangmingwangmainViewPresentor:buildViews()
	return {
		SyguangmingwangmainView.New()
	}
end

return SyguangmingwangmainViewPresentor
