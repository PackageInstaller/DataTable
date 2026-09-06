-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationGameViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationGameViewPresentor", package.seeall)

local IslandStationGameViewPresentor = class("IslandStationGameViewPresentor", ViewPresentor)

function IslandStationGameViewPresentor:ctor()
	IslandStationGameViewPresentor.super.ctor(self)
end

function IslandStationGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationGameViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationgameview.prefab"
	}
end

function IslandStationGameViewPresentor:buildViews()
	return {
		IslandStationGameView.New()
	}
end

return IslandStationGameViewPresentor
