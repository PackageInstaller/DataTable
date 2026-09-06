-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlightdimension/view/OriginLightDimensionMainViewPresentor.lua

module("logic.extensions.originlightdimension.view.OriginLightDimensionMainViewPresentor", package.seeall)

local OriginLightDimensionMainViewPresentor = class("OriginLightDimensionMainViewPresentor", ViewPresentor)

function OriginLightDimensionMainViewPresentor:ctor()
	OriginLightDimensionMainViewPresentor.super.ctor(self)
end

function OriginLightDimensionMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginLightDimensionMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originlightdimension/originlightdimensionmainview.prefab"
	}
end

function OriginLightDimensionMainViewPresentor:buildViews()
	return {
		OriginLightDimensionMainView.New()
	}
end

return OriginLightDimensionMainViewPresentor
