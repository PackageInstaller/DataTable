-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakMainViewPresentor.lua

module("logic.extensions.skypeak.view.SkyPeakMainViewPresentor", package.seeall)

local SkyPeakMainViewPresentor = class("SkyPeakMainViewPresentor", ViewPresentor)

function SkyPeakMainViewPresentor:ctor()
	SkyPeakMainViewPresentor.super.ctor(self)
end

function SkyPeakMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SkyPeakMainViewPresentor:dependWhatResources()
	return {
		"ui/views/skypeak/skypeakmainview.prefab"
	}
end

function SkyPeakMainViewPresentor:buildViews()
	return {
		SkyPeakMainView.New()
	}
end

return SkyPeakMainViewPresentor
