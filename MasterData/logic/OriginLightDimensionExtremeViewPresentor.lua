-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionExtremeViewPresentor.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionExtremeViewPresentor", package.seeall)

local OriginLightDimensionExtremeViewPresentor = class("OriginLightDimensionExtremeViewPresentor", ViewPresentor)

function OriginLightDimensionExtremeViewPresentor:ctor()
	OriginLightDimensionExtremeViewPresentor.super.ctor(self)
end

function OriginLightDimensionExtremeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginLightDimensionExtremeViewPresentor:dependWhatResources()
	return {
		"ui/views/originlightdimension/originlightdimensionextremeview.prefab"
	}
end

function OriginLightDimensionExtremeViewPresentor:buildViews()
	return {
		OriginLightDimensionExtremeView.New()
	}
end

return OriginLightDimensionExtremeViewPresentor
