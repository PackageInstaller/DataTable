-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/map/view/MinMapViewPresentor.lua

module("logic.extensions.map.view.MinMapViewPresentor", package.seeall)

local MinMapViewPresentor = class("MinMapViewPresentor", ViewPresentor)

function MinMapViewPresentor:ctor()
	MinMapViewPresentor.super.ctor(self)
end

function MinMapViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MinMapViewPresentor:dependWhatResources()
	return {
		"ui/views/map/minmapview.prefab"
	}
end

function MinMapViewPresentor:buildViews()
	return {
		MinMapView.New()
	}
end

return MinMapViewPresentor
