-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/view/HolyStripeCopyAddTipViewPresentor.lua

module("logic.extensions.holystripecopy.view.HolyStripeCopyAddTipViewPresentor", package.seeall)

local HolyStripeCopyAddTipViewPresentor = class("HolyStripeCopyAddTipViewPresentor", ViewPresentor)

function HolyStripeCopyAddTipViewPresentor:ctor()
	HolyStripeCopyAddTipViewPresentor.super.ctor(self)
end

function HolyStripeCopyAddTipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeCopyAddTipViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripecopy/holystripecopyaddtipview.prefab"
	}
end

function HolyStripeCopyAddTipViewPresentor:buildViews()
	return {
		HolyStripeCopyAddTipView.New()
	}
end

return HolyStripeCopyAddTipViewPresentor
