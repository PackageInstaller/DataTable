-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/syguangmingwang/SyguangmingwangforceViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.syguangmingwang.SyguangmingwangforceViewPresentor", package.seeall)

local SyguangmingwangforceViewPresentor = class("SyguangmingwangforceViewPresentor", ViewPresentor)

function SyguangmingwangforceViewPresentor:ctor()
	SyguangmingwangforceViewPresentor.super.ctor(self)
end

function SyguangmingwangforceViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SyguangmingwangforceViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/syguangmingwang/syguangmingwangforceview.prefab"
	}
end

function SyguangmingwangforceViewPresentor:buildViews()
	return {
		SyguangmingwangforceView.New()
	}
end

return SyguangmingwangforceViewPresentor
