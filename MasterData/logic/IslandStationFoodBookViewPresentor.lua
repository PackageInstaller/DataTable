-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationFoodBookViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationFoodBookViewPresentor", package.seeall)

local IslandStationFoodBookViewPresentor = class("IslandStationFoodBookViewPresentor", ViewPresentor)

function IslandStationFoodBookViewPresentor:ctor()
	IslandStationFoodBookViewPresentor.super.ctor(self)
end

function IslandStationFoodBookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationFoodBookViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationfoodbookview.prefab"
	}
end

function IslandStationFoodBookViewPresentor:buildViews()
	return {
		IslandStationFoodBookView.New()
	}
end

return IslandStationFoodBookViewPresentor
