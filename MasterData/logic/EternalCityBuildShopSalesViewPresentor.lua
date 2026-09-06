-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBuildShopSalesViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityBuildShopSalesViewPresentor", package.seeall)

local EternalCityBuildShopSalesViewPresentor = class("EternalCityBuildShopSalesViewPresentor", ViewPresentor)

function EternalCityBuildShopSalesViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalCityBuildShopSalesViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcitybuildshopsalesview.prefab"
	}
end

function EternalCityBuildShopSalesViewPresentor:buildViews()
	return {
		EternalCityBuildShopSalesView.New()
	}
end

function EternalCityBuildShopSalesViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EternalCityBuildShopSalesViewPresentor
