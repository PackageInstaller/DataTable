-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/view/PlanetariumprizeViewPresentor.lua

module("logic.extensions.planetarium.view.PlanetariumprizeViewPresentor", package.seeall)

local PlanetariumprizeViewPresentor = class("PlanetariumprizeViewPresentor", ViewPresentor)

function PlanetariumprizeViewPresentor:ctor()
	PlanetariumprizeViewPresentor.super.ctor(self)
end

function PlanetariumprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PlanetariumprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/planetarium/planetariumprizeview.prefab"
	}
end

function PlanetariumprizeViewPresentor:buildViews()
	return {
		PlanetariumprizeView.New()
	}
end

return PlanetariumprizeViewPresentor
