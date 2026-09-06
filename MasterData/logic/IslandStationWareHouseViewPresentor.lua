-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationWareHouseViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationWareHouseViewPresentor", package.seeall)

local IslandStationWareHouseViewPresentor = class("IslandStationWareHouseViewPresentor", ViewPresentor)

function IslandStationWareHouseViewPresentor:ctor()
	IslandStationWareHouseViewPresentor.super.ctor(self)
end

function IslandStationWareHouseViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationWareHouseViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationwarehouseview.prefab"
	}
end

function IslandStationWareHouseViewPresentor:buildViews()
	return {
		IslandStationWareHouseView.New()
	}
end

return IslandStationWareHouseViewPresentor
