-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightMasterPrizeViewPresentor.lua

module("logic.extensions.peaktournament.view.eliminator.HolyLightMasterPrizeViewPresentor", package.seeall)

local HolyLightMasterPrizeViewPresentor = class("HolyLightMasterPrizeViewPresentor", ViewPresentor)

function HolyLightMasterPrizeViewPresentor:ctor()
	HolyLightMasterPrizeViewPresentor.super.ctor(self)
end

function HolyLightMasterPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function HolyLightMasterPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/holylight/holylightmasterprizeview.prefab"
	}
end

function HolyLightMasterPrizeViewPresentor:buildViews()
	return {
		HolyLightMasterPrizeView.New()
	}
end

return HolyLightMasterPrizeViewPresentor
