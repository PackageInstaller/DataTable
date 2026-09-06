-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PowerLandPrizeViewPresentor.lua

module("logic.extensions.powerland.view.PowerLandPrizeViewPresentor", package.seeall)

local PowerLandPrizeViewPresentor = class("PowerLandPrizeViewPresentor", ViewPresentor)

function PowerLandPrizeViewPresentor:ctor()
	PowerLandPrizeViewPresentor.super.ctor(self)
end

function PowerLandPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PowerLandPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/powerland/powerlandprizeview.prefab"
	}
end

function PowerLandPrizeViewPresentor:buildViews()
	return {
		PowerLandPrizeView.New()
	}
end

return PowerLandPrizeViewPresentor
