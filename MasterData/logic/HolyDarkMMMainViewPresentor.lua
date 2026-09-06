-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydarkmm/view/HolyDarkMMMainViewPresentor.lua

module("logic.extensions.holydarkmm.view.HolyDarkMMMainViewPresentor", package.seeall)

local HolyDarkMMMainViewPresentor = class("HolyDarkMMMainViewPresentor", ViewPresentor)

function HolyDarkMMMainViewPresentor:ctor()
	HolyDarkMMMainViewPresentor.super.ctor(self)
end

function HolyDarkMMMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HolyDarkMMMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/holydarkmm/holydarkmmmainview.prefab"
	}
end

function HolyDarkMMMainViewPresentor:buildViews()
	return {
		HolyDarkMMMainView.New()
	}
end

return HolyDarkMMMainViewPresentor
