-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonMiniMapViewPresentor.lua

module("logic.extensions.season.view.SeasonMiniMapViewPresentor", package.seeall)

local SeasonMiniMapViewPresentor = class("SeasonMiniMapViewPresentor", ViewPresentor)

function SeasonMiniMapViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeasonMiniMapViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonminimapview.prefab"
	}
end

function SeasonMiniMapViewPresentor:buildViews()
	return {
		SeasonMiniMapView.New()
	}
end

function SeasonMiniMapViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonMiniMapViewPresentor
