-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationDescribeViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationDescribeViewPresentor", package.seeall)

local IslandStationDescribeViewPresentor = class("IslandStationDescribeViewPresentor", ViewPresentor)

function IslandStationDescribeViewPresentor:ctor()
	IslandStationDescribeViewPresentor.super.ctor(self)
end

function IslandStationDescribeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationDescribeViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationdescribeview.prefab"
	}
end

function IslandStationDescribeViewPresentor:buildViews()
	return {
		IslandStationDescribeView.New()
	}
end

return IslandStationDescribeViewPresentor
