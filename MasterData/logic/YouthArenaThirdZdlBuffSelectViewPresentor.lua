-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdZdlBuffSelectViewPresentor.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdZdlBuffSelectViewPresentor", package.seeall)

local YouthArenaThirdZdlBuffSelectViewPresentor = class("YouthArenaThirdZdlBuffSelectViewPresentor", ViewPresentor)

function YouthArenaThirdZdlBuffSelectViewPresentor:ctor()
	YouthArenaThirdZdlBuffSelectViewPresentor.super.ctor(self)
end

function YouthArenaThirdZdlBuffSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function YouthArenaThirdZdlBuffSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/youtharenathird/youtharenathirdzdlbuffselectview.prefab"
	}
end

function YouthArenaThirdZdlBuffSelectViewPresentor:buildViews()
	return {
		YouthArenaThirdZdlBuffSelectView.New()
	}
end

return YouthArenaThirdZdlBuffSelectViewPresentor
