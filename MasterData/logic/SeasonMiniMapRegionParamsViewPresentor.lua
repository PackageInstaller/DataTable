-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonMiniMapRegionParamsViewPresentor.lua

module("logic.extensions.season.view.SeasonMiniMapRegionParamsViewPresentor", package.seeall)

local SeasonMiniMapRegionParamsViewPresentor = class("SeasonMiniMapRegionParamsViewPresentor", ViewPresentor)

function SeasonMiniMapRegionParamsViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeasonMiniMapRegionParamsViewPresentor:dependWhatResources()
	return {
		"ui/views/season/seasonminimapregionparamsview.prefab"
	}
end

function SeasonMiniMapRegionParamsViewPresentor:buildViews()
	return {
		SeasonMiniMapRegionParamsView.New()
	}
end

function SeasonMiniMapRegionParamsViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return SeasonMiniMapRegionParamsViewPresentor
