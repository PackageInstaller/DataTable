-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownBuffSelectViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownBuffSelectViewPresentor", package.seeall)

local ShowDownBuffSelectViewPresentor = class("ShowDownBuffSelectViewPresentor", ViewPresentor)

function ShowDownBuffSelectViewPresentor:ctor()
	ShowDownBuffSelectViewPresentor.super.ctor(self)
end

function ShowDownBuffSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShowDownBuffSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownbuffselectview.prefab"
	}
end

function ShowDownBuffSelectViewPresentor:buildViews()
	return {
		ShowDownBuffSelectView.New()
	}
end

return ShowDownBuffSelectViewPresentor
