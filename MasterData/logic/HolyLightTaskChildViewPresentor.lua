-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eventtasksummary/view/tab/holylight/HolyLightTaskChildViewPresentor.lua

module("logic.extensions.eventtasksummary.view.tab.holylight.HolyLightTaskChildViewPresentor", package.seeall)

local HolyLightTaskChildViewPresentor = class("HolyLightTaskChildViewPresentor", ViewPresentor)

function HolyLightTaskChildViewPresentor:ctor()
	HolyLightTaskChildViewPresentor.super.ctor(self)
end

function HolyLightTaskChildViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyLightTaskChildViewPresentor:dependWhatResources()
	return {
		"ui/views/eventtasksummary/holylight/holylighttaskchildview.prefab"
	}
end

function HolyLightTaskChildViewPresentor:buildViews()
	return {
		HolyLightTaskChildView.New()
	}
end

function HolyLightTaskChildViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return HolyLightTaskChildViewPresentor
