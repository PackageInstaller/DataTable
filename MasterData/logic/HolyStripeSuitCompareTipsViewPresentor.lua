-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitCompareTipsViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSuitCompareTipsViewPresentor", package.seeall)

local HolyStripeSuitCompareTipsViewPresentor = class("HolyStripeSuitCompareTipsViewPresentor", ViewPresentor)

function HolyStripeSuitCompareTipsViewPresentor:ctor()
	HolyStripeSuitCompareTipsViewPresentor.super.ctor(self)
end

function HolyStripeSuitCompareTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeSuitCompareTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripecomparetipview.prefab"
	}
end

function HolyStripeSuitCompareTipsViewPresentor:buildViews()
	return {
		HolyStripeSuitCompareTipsView.New()
	}
end

function HolyStripeSuitCompareTipsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeSuitCompareTipsViewPresentor:onClickOutside()
	self:close()
end

return HolyStripeSuitCompareTipsViewPresentor
