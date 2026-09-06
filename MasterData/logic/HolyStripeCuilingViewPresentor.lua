-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeCuilingViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeCuilingViewPresentor", package.seeall)

local HolyStripeCuilingViewPresentor = class("HolyStripeCuilingViewPresentor", ViewPresentor)

function HolyStripeCuilingViewPresentor:ctor()
	HolyStripeCuilingViewPresentor.super.ctor(self)
end

function HolyStripeCuilingViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeCuilingViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripestrengthview.prefab"
	}
end

function HolyStripeCuilingViewPresentor:buildViews()
	return {
		HolyStripeCuilingView.New()
	}
end

return HolyStripeCuilingViewPresentor
