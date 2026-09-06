-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/map/view/MapViewPresentor.lua

module("logic.extensions.map.view.MapViewPresentor", package.seeall)

local MapViewPresentor = class("MapViewPresentor", ViewPresentor)

function MapViewPresentor:ctor()
	MapViewPresentor.super.ctor(self)
end

function MapViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MapViewPresentor:dependWhatResources()
	return {
		"ui/views/map/mapview.prefab"
	}
end

function MapViewPresentor:buildViews()
	return {
		MapView.New()
	}
end

return MapViewPresentor
