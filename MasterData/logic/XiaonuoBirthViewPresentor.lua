-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/XiaonuoBirthViewPresentor.lua

module("logic.extensions.bonus.view.XiaonuoBirthViewPresentor", package.seeall)

local XiaonuoBirthViewPresentor = class("XiaonuoBirthViewPresentor", ViewWithGuidePresentor)

function XiaonuoBirthViewPresentor:ctor()
	XiaonuoBirthViewPresentor.super.ctor(self)
end

function XiaonuoBirthViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaonuoBirthViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/xiaonuobirthview.prefab"
	}
end

function XiaonuoBirthViewPresentor:buildViews()
	return {
		XiaonuoBirthView.New()
	}
end

return XiaonuoBirthViewPresentor
