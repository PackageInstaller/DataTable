-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaysportswish/view/SportsupgradeViewPresentor.lua

module("logic.extensions.birthdaysportswish.view.SportsupgradeViewPresentor", package.seeall)

local SportsupgradeViewPresentor = class("SportsupgradeViewPresentor", ViewPresentor)

function SportsupgradeViewPresentor:ctor()
	SportsupgradeViewPresentor.super.ctor(self)
end

function SportsupgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SportsupgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/birthdaysportswish/sportsupgradeview.prefab"
	}
end

function SportsupgradeViewPresentor:buildViews()
	return {
		SportsUpgradeView.New()
	}
end

return SportsupgradeViewPresentor
