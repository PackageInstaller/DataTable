-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/islandstation/view/IslandStationFillShopViewPresentor.lua

module("logic.extensions.islandstation.view.IslandStationFillShopViewPresentor", package.seeall)

local IslandStationFillShopViewPresentor = class("IslandStationFillShopViewPresentor", ViewPresentor)

function IslandStationFillShopViewPresentor:ctor()
	IslandStationFillShopViewPresentor.super.ctor(self)
end

function IslandStationFillShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IslandStationFillShopViewPresentor:dependWhatResources()
	return {
		"ui/views/islandstation/islandstationfillshopview.prefab"
	}
end

function IslandStationFillShopViewPresentor:buildViews()
	return {
		IslandStationFillShopView.New()
	}
end

return IslandStationFillShopViewPresentor
