-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/eternalfarm/view/EternalFarmShopViewPresentor.lua

module("logic.extensions.eternalfarm.view.EternalFarmShopViewPresentor", package.seeall)

local EternalFarmShopViewPresentor = class("EternalFarmShopViewPresentor", ViewPresentor)

function EternalFarmShopViewPresentor:ctor()
	EternalFarmShopViewPresentor.super.ctor(self)
end

function EternalFarmShopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function EternalFarmShopViewPresentor:dependWhatResources()
	return {
		"ui/views/eternalfarm/eternalfarmshopview.prefab"
	}
end

function EternalFarmShopViewPresentor:buildViews()
	return {
		EternalFarmShopView.New()
	}
end

return EternalFarmShopViewPresentor
