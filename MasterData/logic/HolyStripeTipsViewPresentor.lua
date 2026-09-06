-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeTipsViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeTipsViewPresentor", package.seeall)

local HolyStripeTipsViewPresentor = class("HolyStripeTipsViewPresentor", ViewPresentor)

function HolyStripeTipsViewPresentor:ctor()
	HolyStripeTipsViewPresentor.super.ctor(self)
end

function HolyStripeTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function HolyStripeTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripetipview.prefab"
	}
end

function HolyStripeTipsViewPresentor:buildViews()
	return {
		HolyStripeTipsView.New()
	}
end

function HolyStripeTipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeTipsViewPresentor:onClickOutside()
	self:close()
end

return HolyStripeTipsViewPresentor
