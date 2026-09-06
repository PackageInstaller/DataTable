-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanpetupgradeViewPresentor.lua

module("logic.extensions.richmanxplan.view.RmxplanpetupgradeViewPresentor", package.seeall)

local RmxplanpetupgradeViewPresentor = class("RmxplanpetupgradeViewPresentor", ViewPresentor)

function RmxplanpetupgradeViewPresentor:ctor()
	RmxplanpetupgradeViewPresentor.super.ctor(self)
end

function RmxplanpetupgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RmxplanpetupgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/richmanxplan/rmxplanpetupgradeview.prefab"
	}
end

function RmxplanpetupgradeViewPresentor:buildViews()
	return {
		RmxplanpetupgradeView.New()
	}
end

return RmxplanpetupgradeViewPresentor
