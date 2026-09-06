-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalcity/view/EternalCityPetShopViewPresentor.lua

module("logic.extensions.eternalcity.view.EternalCityPetShopViewPresentor", package.seeall)

local EternalCityPetShopViewPresentor = class("EternalCityPetShopViewPresentor", ViewPresentor)

function EternalCityPetShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EternalCityPetShopViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalcity/eternalcitypetshopview.prefab"
	}
end

function EternalCityPetShopViewPresentor:buildViews()
	return {
		EternalCityPetShopView.New()
	}
end

return EternalCityPetShopViewPresentor
