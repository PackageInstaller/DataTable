-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/view/HdzeropayViewPresentor.lua

module("logic.extensions.zeropay.view.HdzeropayViewPresentor", package.seeall)

local HdzeropayViewPresentor = class("HdzeropayViewPresentor", ViewPresentor)

function HdzeropayViewPresentor:ctor()
	HdzeropayViewPresentor.super.ctor(self)
end

function HdzeropayViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdzeropayViewPresentor:dependWhatResources()
	return {
		"ui/views/zeropay/hdzeropayview.prefab"
	}
end

function HdzeropayViewPresentor:buildViews()
	return {
		HdzeropayView.New()
	}
end

return HdzeropayViewPresentor
