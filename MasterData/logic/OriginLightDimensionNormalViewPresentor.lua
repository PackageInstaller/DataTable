-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionNormalViewPresentor.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionNormalViewPresentor", package.seeall)

local OriginLightDimensionNormalViewPresentor = class("OriginLightDimensionNormalViewPresentor", ViewPresentor)

function OriginLightDimensionNormalViewPresentor:ctor()
	OriginLightDimensionNormalViewPresentor.super.ctor(self)
end

function OriginLightDimensionNormalViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginLightDimensionNormalViewPresentor:dependWhatResources()
	return {
		"ui/views/originlightdimension/originlightdimensionnormalview.prefab"
	}
end

function OriginLightDimensionNormalViewPresentor:buildViews()
	return {
		OriginLightDimensionNormalView.New()
	}
end

return OriginLightDimensionNormalViewPresentor
