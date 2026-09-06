-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripePosFilterViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripePosFilterViewPresentor", package.seeall)

local HolyStripePosFilterViewPresentor = class("HolyStripePosFilterViewPresentor", ViewPresentor)

function HolyStripePosFilterViewPresentor:ctor()
	HolyStripePosFilterViewPresentor.super.ctor(self)
end

function HolyStripePosFilterViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripePosFilterViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripeposlfitlerview.prefab"
	}
end

function HolyStripePosFilterViewPresentor:buildViews()
	return {
		HolyStripePosFilterView.New()
	}
end

function HolyStripePosFilterViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripePosFilterViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripePosFilterViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripePosFilterViewPresentor
