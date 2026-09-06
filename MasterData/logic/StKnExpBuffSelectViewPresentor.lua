-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/stknexp/view/StKnExpBuffSelectViewPresentor.lua

module("logic.extensions.stknexp.view.StKnExpBuffSelectViewPresentor", package.seeall)

local StKnExpBuffSelectViewPresentor = class("StKnExpBuffSelectViewPresentor", ViewPresentor)

function StKnExpBuffSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function StKnExpBuffSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/stknexp/stknexpbuffselectview.prefab"
	}
end

function StKnExpBuffSelectViewPresentor:buildViews()
	return {
		StKnExpBuffSelectView.New()
	}
end

return StKnExpBuffSelectViewPresentor
