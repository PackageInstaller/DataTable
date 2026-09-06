-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/view/PlanetariumViewPresentor.lua

module("logic.extensions.planetarium.view.PlanetariumViewPresentor", package.seeall)

local PlanetariumViewPresentor = class("PlanetariumViewPresentor", ViewPresentor)

function PlanetariumViewPresentor:ctor()
	PlanetariumViewPresentor.super.ctor(self)
end

function PlanetariumViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PlanetariumViewPresentor:dependWhatResources()
	return {
		"ui/views/planetarium/planetariumview.prefab"
	}
end

function PlanetariumViewPresentor:buildViews()
	return {
		PlanetariumView.New()
	}
end

return PlanetariumViewPresentor
