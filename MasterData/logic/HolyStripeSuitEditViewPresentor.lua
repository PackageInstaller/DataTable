-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitEditViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSuitEditViewPresentor", package.seeall)

local HolyStripeSuitEditViewPresentor = class("HolyStripeSuitEditViewPresentor", ViewPresentor)

function HolyStripeSuitEditViewPresentor:ctor()
	HolyStripeSuitEditViewPresentor.super.ctor(self)
end

function HolyStripeSuitEditViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyStripeSuitEditViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripesuiteditview.prefab"
	}
end

function HolyStripeSuitEditViewPresentor:buildViews()
	return {
		HolyStripeSuitEditView.New(),
		HolyStripeBagView.New()
	}
end

function HolyStripeSuitEditViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeSuitEditViewPresentor
