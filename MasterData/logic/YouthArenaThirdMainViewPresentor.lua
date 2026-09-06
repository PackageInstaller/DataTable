-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdMainViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdMainViewPresentor", package.seeall)

local YouthArenaThirdMainViewPresentor = class("YouthArenaThirdMainViewPresentor", ViewPresentor)

function YouthArenaThirdMainViewPresentor:ctor()
	YouthArenaThirdMainViewPresentor.super.ctor(self)
end

function YouthArenaThirdMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdMainViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdmainview.prefab"
	}
end

function YouthArenaThirdMainViewPresentor:buildViews()
	return {
		YouthArenaThirdMainView.New()
	}
end

return YouthArenaThirdMainViewPresentor
