-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitReplaceTipsViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSuitReplaceTipsViewPresentor", package.seeall)

local HolyStripeSuitReplaceTipsViewPresentor = class("HolyStripeSuitReplaceTipsViewPresentor", ViewPresentor)

function HolyStripeSuitReplaceTipsViewPresentor:ctor()
	HolyStripeSuitReplaceTipsViewPresentor.super.ctor(self)
end

function HolyStripeSuitReplaceTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeSuitReplaceTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripesuittipsview.prefab"
	}
end

function HolyStripeSuitReplaceTipsViewPresentor:buildViews()
	return {
		HolyStripeSuitReplaceTipsView.New()
	}
end

function HolyStripeSuitReplaceTipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeSuitReplaceTipsViewPresentor
