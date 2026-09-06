-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdMatchHallViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdMatchHallViewPresentor", package.seeall)

local YouthArenaThirdMatchHallViewPresentor = class("YouthArenaThirdMatchHallViewPresentor", ViewPresentor)

function YouthArenaThirdMatchHallViewPresentor:ctor()
	YouthArenaThirdMatchHallViewPresentor.super.ctor(self)
end

function YouthArenaThirdMatchHallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdMatchHallViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdmatchhallview.prefab"
	}
end

function YouthArenaThirdMatchHallViewPresentor:buildViews()
	return {
		YouthArenaThirdMatchHallView.New()
	}
end

return YouthArenaThirdMatchHallViewPresentor
