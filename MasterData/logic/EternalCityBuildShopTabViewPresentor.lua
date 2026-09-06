-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityBuildShopTabViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityBuildShopTabViewPresentor", package.seeall)

local EternalCityBuildShopTabViewPresentor = class("EternalCityBuildShopTabViewPresentor", ViewPresentor)

function EternalCityBuildShopTabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalCityBuildShopTabViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcitybuildshoptabview.prefab"
	}
end

function EternalCityBuildShopTabViewPresentor:buildViews()
	return {
		EternalCityBuildShopTabView.New()
	}
end

return EternalCityBuildShopTabViewPresentor
