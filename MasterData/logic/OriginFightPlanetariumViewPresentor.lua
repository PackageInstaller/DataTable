-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originfight/view/OriginFightPlanetariumViewPresentor.lua

module("logic.extensions.planetarium.view.OriginFightPlanetariumViewPresentor", package.seeall)

local OriginFightPlanetariumViewPresentor = class("OriginFightPlanetariumViewPresentor", ViewPresentor)

function OriginFightPlanetariumViewPresentor:ctor()
	OriginFightPlanetariumViewPresentor.super.ctor(self)
end

function OriginFightPlanetariumViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginFightPlanetariumViewPresentor:dependWhatResources()
	return {
		"ui/views/originfight/originfightplanetariumview.prefab"
	}
end

function OriginFightPlanetariumViewPresentor:buildViews()
	return {
		OriginFightPlanetariumView.New()
	}
end

return OriginFightPlanetariumViewPresentor
