-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitConditionSortViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSuitConditionSortViewPresentor", package.seeall)

local HolyStripeSuitConditionSortViewPresentor = class("HolyStripeSuitConditionSortViewPresentor", ViewPresentor)

function HolyStripeSuitConditionSortViewPresentor:ctor()
	HolyStripeSuitConditionSortViewPresentor.super.ctor(self)
end

function HolyStripeSuitConditionSortViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeSuitConditionSortViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripelevelfitlerview.prefab"
	}
end

function HolyStripeSuitConditionSortViewPresentor:buildViews()
	return {
		HolyStripeSuitConditionSortView.New()
	}
end

function HolyStripeSuitConditionSortViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

function HolyStripeConditionSortViewPresentor:setGrayMaskGO(grayMaskGO)
	HolyStripeConditionSortViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
end

return HolyStripeSuitConditionSortViewPresentor
