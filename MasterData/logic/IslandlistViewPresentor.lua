-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/view/IslandlistViewPresentor.lua

module("logic.extensions.login.view.IslandlistViewPresentor", package.seeall)

local IslandlistViewPresentor = class("IslandlistViewPresentor", ViewPresentor)

function IslandlistViewPresentor:ctor()
	IslandlistViewPresentor.super.ctor(self)
end

function IslandlistViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function IslandlistViewPresentor:dependWhatResources()
	return {
		"ui/views/login/islandlistview.prefab"
	}
end

function IslandlistViewPresentor:buildViews()
	return {
		IslandlistView.New()
	}
end

return IslandlistViewPresentor
