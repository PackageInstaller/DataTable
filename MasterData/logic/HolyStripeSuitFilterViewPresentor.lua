-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitFilterViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSuitFilterViewPresentor", package.seeall)

local HolyStripeSuitFilterViewPresentor = class("HolyStripeSuitFilterViewPresentor", ViewPresentor)

function HolyStripeSuitFilterViewPresentor:ctor()
	HolyStripeSuitFilterViewPresentor.super.ctor(self)
end

function HolyStripeSuitFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeSuitFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripesuitfilterview.prefab"
	}
end

function HolyStripeSuitFilterViewPresentor:buildViews()
	return {
		HolyStripeSuitFilterView.New()
	}
end

function HolyStripeSuitFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeSuitFilterViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeSuitFilterViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeSuitFilterViewPresentor
