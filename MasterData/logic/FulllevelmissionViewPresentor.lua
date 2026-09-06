-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/FulllevelmissionViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.FulllevelmissionViewPresentor", package.seeall)

local FulllevelmissionViewPresentor = class("FulllevelmissionViewPresentor", ViewPresentor)

function FulllevelmissionViewPresentor:ctor()
	FulllevelmissionViewPresentor.super.ctor(self)
end

function FulllevelmissionViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FulllevelmissionViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/fulllevelmissionview.prefab"
	}
end

function FulllevelmissionViewPresentor:buildViews()
	return {
		FulllevelmissionView.New()
	}
end

return FulllevelmissionViewPresentor
