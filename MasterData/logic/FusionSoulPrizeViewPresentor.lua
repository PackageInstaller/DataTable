-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fusionsoul/view/FusionSoulPrizeViewPresentor.lua

module("logic.extensions.fusionsoul.view.FusionSoulPrizeViewPresentor", package.seeall)

local FusionSoulPrizeViewPresentor = class("FusionSoulPrizeViewPresentor", ViewPresentor)

function FusionSoulPrizeViewPresentor:ctor()
	FusionSoulPrizeViewPresentor.super.ctor(self)
end

function FusionSoulPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FusionSoulPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/fusionsoul/fusionsoulprizeview.prefab"
	}
end

function FusionSoulPrizeViewPresentor:buildViews()
	return {
		FusionSoulPrizeView.New()
	}
end

return FusionSoulPrizeViewPresentor
