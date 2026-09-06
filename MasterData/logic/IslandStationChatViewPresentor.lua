-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationChatViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationChatViewPresentor", package.seeall)

local IslandStationChatViewPresentor = class("IslandStationChatViewPresentor", ViewPresentor)

function IslandStationChatViewPresentor:ctor()
	IslandStationChatViewPresentor.super.ctor(self)
end

function IslandStationChatViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationChatViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationchatview.prefab"
	}
end

function IslandStationChatViewPresentor:buildViews()
	return {
		IslandStationChatView.New()
	}
end

return IslandStationChatViewPresentor
