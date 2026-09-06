-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationMakeFoodViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationMakeFoodViewPresentor", package.seeall)

local IslandStationMakeFoodViewPresentor = class("IslandStationMakeFoodViewPresentor", ViewPresentor)

function IslandStationMakeFoodViewPresentor:ctor()
	IslandStationMakeFoodViewPresentor.super.ctor(self)
end

function IslandStationMakeFoodViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationMakeFoodViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationmakefoodview.prefab"
	}
end

function IslandStationMakeFoodViewPresentor:buildViews()
	return {
		IslandStationMakeFoodView.New()
	}
end

return IslandStationMakeFoodViewPresentor
