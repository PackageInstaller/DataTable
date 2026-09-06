-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeBagViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeBagViewPresentor", package.seeall)

local HolyStripeBagViewPresentor = class("HolyStripeBagViewPresentor", ViewPresentor)

function HolyStripeBagViewPresentor:ctor()
	HolyStripeBagViewPresentor.super.ctor(self)
end

function HolyStripeBagViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeBagViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripebagview.prefab"
	}
end

function HolyStripeBagViewPresentor:buildViews()
	return {
		HolyStripeBagView.New(),
		HolyStripeBagLeftView.New()
	}
end

function HolyStripeBagViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeBagViewPresentor
