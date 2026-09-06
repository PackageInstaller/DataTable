-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationGetMaterialViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationGetMaterialViewPresentor", package.seeall)

local IslandStationGetMaterialViewPresentor = class("IslandStationGetMaterialViewPresentor", ViewPresentor)

function IslandStationGetMaterialViewPresentor:ctor()
	IslandStationGetMaterialViewPresentor.super.ctor(self)
end

function IslandStationGetMaterialViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationGetMaterialViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationgetmaterialview.prefab"
	}
end

function IslandStationGetMaterialViewPresentor:buildViews()
	return {
		IslandStationGetMaterialView.New()
	}
end

return IslandStationGetMaterialViewPresentor
