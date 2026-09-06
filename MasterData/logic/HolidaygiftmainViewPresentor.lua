-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holidaygift/view/HolidaygiftmainViewPresentor.lua

module("logic.extensions.holidaygift.view.HolidaygiftmainViewPresentor", package.seeall)

local HolidaygiftmainViewPresentor = class("HolidaygiftmainViewPresentor", ViewPresentor)

function HolidaygiftmainViewPresentor:ctor()
	HolidaygiftmainViewPresentor.super.ctor(self)
end

function HolidaygiftmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolidaygiftmainViewPresentor:dependWhatResources()
	return {
		"ui/views/holidaygift/holidaygiftmainview.prefab"
	}
end

function HolidaygiftmainViewPresentor:buildViews()
	return {
		HolidayGiftMainView.New()
	}
end

return HolidaygiftmainViewPresentor
