-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/christmasandnewyear/SystemupgradeViewPresentor.lua

module("logic.extensions.bonus.view.christmasandnewyear.SystemupgradeViewPresentor", package.seeall)

local SystemupgradeViewPresentor = class("SystemupgradeViewPresentor", ViewPresentor)

function SystemupgradeViewPresentor:ctor()
	SystemupgradeViewPresentor.super.ctor(self)
end

function SystemupgradeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SystemupgradeViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/xiaonuorightview.prefab"
	}
end

function SystemupgradeViewPresentor:buildViews()
	return {
		SystemupgradeView.New()
	}
end

return SystemupgradeViewPresentor
