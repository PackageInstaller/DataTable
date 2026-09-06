-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitypopup/view/HdWelfareMonthPopViewPresentor.lua

module("logic.extensions.activitypopup.view.HdWelfareMonthPopViewPresentor", package.seeall)

local HdWelfareMonthPopViewPresentor = class("HdWelfareMonthPopViewPresentor", ViewPresentor)

function HdWelfareMonthPopViewPresentor:ctor()
	HdWelfareMonthPopViewPresentor.super.ctor(self)
end

function HdWelfareMonthPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HdWelfareMonthPopViewPresentor:dependWhatResources()
	return {
		"ui/views/activitypopup/hdwelfaremonthpopview.prefab"
	}
end

function HdWelfareMonthPopViewPresentor:buildViews()
	return {
		HdWelfareMonthPopView.New()
	}
end

return HdWelfareMonthPopViewPresentor
