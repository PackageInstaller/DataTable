-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripecopy/view/HolyStripeCopyViewPresentor.lua

module("logic.extensions.holystripecopy.view.HolyStripeCopyViewPresentor", package.seeall)

local HolyStripeCopyViewPresentor = class("HolyStripeCopyViewPresentor", ViewPresentor)

function HolyStripeCopyViewPresentor:ctor()
	HolyStripeCopyViewPresentor.super.ctor(self)
end

function HolyStripeCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripecopy/holystripecopyview.prefab"
	}
end

function HolyStripeCopyViewPresentor:buildViews()
	return {
		HolyStripeCopyView.New()
	}
end

function HolyStripeCopyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeCopyViewPresentor
