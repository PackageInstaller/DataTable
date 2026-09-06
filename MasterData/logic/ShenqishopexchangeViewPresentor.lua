-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activityshop/view/ShenqishopexchangeViewPresentor.lua

module("logic.extensions.activityshop.view.ShenqishopexchangeViewPresentor", package.seeall)

local ShenqishopexchangeViewPresentor = class("ShenqishopexchangeViewPresentor", ViewPresentor)

function ShenqishopexchangeViewPresentor:ctor()
	ShenqishopexchangeViewPresentor.super.ctor(self)
end

function ShenqishopexchangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShenqishopexchangeViewPresentor:dependWhatResources()
	return {
		"ui/views/activityshop/shenqishopexchangeview.prefab"
	}
end

function ShenqishopexchangeViewPresentor:buildViews()
	return {
		ShenqishopexchangeView.New()
	}
end

return ShenqishopexchangeViewPresentor
