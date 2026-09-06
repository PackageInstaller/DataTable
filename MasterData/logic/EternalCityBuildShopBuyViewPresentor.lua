-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBuildShopBuyViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityBuildShopBuyViewPresentor", package.seeall)

local EternalCityBuildShopBuyViewPresentor = class("EternalCityBuildShopBuyViewPresentor", ViewPresentor)

function EternalCityBuildShopBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalCityBuildShopBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcitybuildshopbuyview.prefab"
	}
end

function EternalCityBuildShopBuyViewPresentor:buildViews()
	return {
		EternalCityBuildShopBuyView.New()
	}
end

function EternalCityBuildShopBuyViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return EternalCityBuildShopBuyViewPresentor
