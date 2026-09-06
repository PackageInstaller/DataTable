-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeSuitGroupViewPresentor.lua

module("logic.extensions.holystripe.view.HolyStripeSuitGroupViewPresentor", package.seeall)

local HolyStripeSuitGroupViewPresentor = class("HolyStripeSuitGroupViewPresentor", ViewPresentor)

function HolyStripeSuitGroupViewPresentor:ctor()
	HolyStripeSuitGroupViewPresentor.super.ctor(self)
end

function HolyStripeSuitGroupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyStripeSuitGroupViewPresentor:dependWhatResources()
	return {
		"ui/views/holystripe/holystripesuitgroupview.prefab"
	}
end

function HolyStripeSuitGroupViewPresentor:buildViews()
	return {
		HolyStripeSuitGroupView.New()
	}
end

function HolyStripeSuitGroupViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyStripeSuitGroupViewPresentor
