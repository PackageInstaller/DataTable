-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationMainViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationMainViewPresentor", package.seeall)

local IslandStationMainViewPresentor = class("IslandStationMainViewPresentor", ViewPresentor)

function IslandStationMainViewPresentor:ctor()
	IslandStationMainViewPresentor.super.ctor(self)
end

function IslandStationMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationMainViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationmainview.prefab"
	}
end

function IslandStationMainViewPresentor:buildViews()
	return {
		IslandStationMainView.New()
	}
end

return IslandStationMainViewPresentor
