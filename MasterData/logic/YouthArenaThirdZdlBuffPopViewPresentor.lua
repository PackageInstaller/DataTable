-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdZdlBuffPopViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdZdlBuffPopViewPresentor", package.seeall)

local YouthArenaThirdZdlBuffPopViewPresentor = class("YouthArenaThirdZdlBuffPopViewPresentor", ViewPresentor)

function YouthArenaThirdZdlBuffPopViewPresentor:ctor()
	YouthArenaThirdZdlBuffPopViewPresentor.super.ctor(self)
end

function YouthArenaThirdZdlBuffPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function YouthArenaThirdZdlBuffPopViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdzdlbuffpopview.prefab"
	}
end

function YouthArenaThirdZdlBuffPopViewPresentor:buildViews()
	return {
		YouthArenaThirdZdlBuffPopView.New()
	}
end

return YouthArenaThirdZdlBuffPopViewPresentor
