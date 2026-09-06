-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/raiders/RaidersSmallViewPresentor.lua

module("logic.extensions.legend.view.raiders.RaidersSmallViewPresentor", package.seeall)

local RaidersSmallViewPresentor = class("RaidersSmallViewPresentor", ViewPresentor)

function RaidersSmallViewPresentor:ctor()
	RaidersSmallViewPresentor.super.ctor(self)
end

function RaidersSmallViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function RaidersSmallViewPresentor:dependWhatResources()
	return {
		"ui/views/legend/raiderssmallview.prefab"
	}
end

function RaidersSmallViewPresentor:buildViews()
	return {
		RaidersSmallView.New(),
		RaidersCommonView.New()
	}
end

return RaidersSmallViewPresentor
