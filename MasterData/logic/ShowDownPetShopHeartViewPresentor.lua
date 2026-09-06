-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownPetShopHeartViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownPetShopHeartViewPresentor", package.seeall)

local ShowDownPetShopHeartViewPresentor = class("ShowDownPetShopHeartViewPresentor", ViewPresentor)

function ShowDownPetShopHeartViewPresentor:ctor()
	ShowDownPetShopHeartViewPresentor.super.ctor(self)
end

function ShowDownPetShopHeartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownPetShopHeartViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownpetshopheartview.prefab"
	}
end

function ShowDownPetShopHeartViewPresentor:buildViews()
	return {
		ShowDownPetShopHeartView.New()
	}
end

return ShowDownPetShopHeartViewPresentor
