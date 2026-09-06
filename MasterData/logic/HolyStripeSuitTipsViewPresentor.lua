-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitTipsViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSuitTipsViewPresentor", package.seeall)

local HolyStripeSuitTipsViewPresentor = class("HolyStripeSuitTipsViewPresentor", ViewPresentor)

function HolyStripeSuitTipsViewPresentor:ctor()
	HolyStripeSuitTipsViewPresentor.super.ctor(self)
end

function HolyStripeSuitTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeSuitTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripetipview.prefab"
	}
end

function HolyStripeSuitTipsViewPresentor:buildViews()
	return {
		HolyStripeSuitTipsView.New()
	}
end

function HolyStripeSuitTipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeSuitTipsViewPresentor:onClickOutside()
	self:close()
end

return HolyStripeSuitTipsViewPresentor
