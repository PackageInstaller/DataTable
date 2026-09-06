-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionExtResultViewPresentor.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionExtResultViewPresentor", package.seeall)

local OriginLightDimensionExtResultViewPresentor = class("OriginLightDimensionExtResultViewPresentor", ViewPresentor)

function OriginLightDimensionExtResultViewPresentor:ctor()
	OriginLightDimensionExtResultViewPresentor.super.ctor(self)
end

function OriginLightDimensionExtResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginLightDimensionExtResultViewPresentor:dependWhatResources()
	return {
		"ui/views/originlightdimension/originlightdimensionextresultview.prefab"
	}
end

function OriginLightDimensionExtResultViewPresentor:buildViews()
	return {
		OriginLightDimensionExtResultView.New()
	}
end

return OriginLightDimensionExtResultViewPresentor
