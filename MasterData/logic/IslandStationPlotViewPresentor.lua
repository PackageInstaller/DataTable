-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationPlotViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationPlotViewPresentor", package.seeall)

local IslandStationPlotViewPresentor = class("IslandStationPlotViewPresentor", ViewPresentor)

function IslandStationPlotViewPresentor:ctor()
	IslandStationPlotViewPresentor.super.ctor(self)
end

function IslandStationPlotViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationPlotViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationplotview.prefab"
	}
end

function IslandStationPlotViewPresentor:buildViews()
	return {
		IslandStationPlotView.New()
	}
end

return IslandStationPlotViewPresentor
