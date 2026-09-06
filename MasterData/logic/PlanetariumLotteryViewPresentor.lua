-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/view/PlanetariumLotteryViewPresentor.lua

module("logic.extensions.planetarium.view.PlanetariumLotteryViewPresentor", package.seeall)

local PlanetariumLotteryViewPresentor = class("PlanetariumLotteryViewPresentor", ViewPresentor)

function PlanetariumLotteryViewPresentor:ctor()
	PlanetariumLotteryViewPresentor.super.ctor(self)
end

function PlanetariumLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PlanetariumLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/planetarium/planetariumlotteryview.prefab"
	}
end

function PlanetariumLotteryViewPresentor:buildViews()
	return {
		PlanetariumLotteryView.New()
	}
end

return PlanetariumLotteryViewPresentor
