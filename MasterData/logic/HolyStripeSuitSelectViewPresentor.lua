-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitSelectViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSuitSelectViewPresentor", package.seeall)

local HolyStripeSuitSelectViewPresentor = class("HolyStripeSuitSelectViewPresentor", ViewPresentor)

function HolyStripeSuitSelectViewPresentor:ctor()
	HolyStripeSuitSelectViewPresentor.super.ctor(self)
end

function HolyStripeSuitSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeSuitSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripesuitselectview.prefab"
	}
end

function HolyStripeSuitSelectViewPresentor:buildViews()
	return {
		HolyStripeSuitSelectView.New()
	}
end

function HolyStripeSuitSelectViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeSuitSelectViewPresentor
