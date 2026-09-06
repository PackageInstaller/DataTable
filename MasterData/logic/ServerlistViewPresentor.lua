-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/ServerlistViewPresentor.lua

module("logic.extensions.login.view.ServerlistViewPresentor", package.seeall)

local ServerlistViewPresentor = class("ServerlistViewPresentor", ViewPresentor)

function ServerlistViewPresentor:ctor()
	ServerlistViewPresentor.super.ctor(self)
end

function ServerlistViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ServerlistViewPresentor:dependWhatResources()
	return {
		"ui/views/login/serverlistview.prefab"
	}
end

function ServerlistViewPresentor:buildViews()
	return {
		ServerlistView.New()
	}
end

return ServerlistViewPresentor
