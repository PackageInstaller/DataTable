-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownPetShopViewPresentor.lua

module("logic.extensions.dragonpsychicclg.view.ShowDownPetShopViewPresentor", package.seeall)

local ShowDownPetShopViewPresentor = class("ShowDownPetShopViewPresentor", ViewPresentor)

function ShowDownPetShopViewPresentor:ctor()
	ShowDownPetShopViewPresentor.super.ctor(self)
end

function ShowDownPetShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownPetShopViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownpetshopview.prefab"
	}
end

function ShowDownPetShopViewPresentor:buildViews()
	return {
		ShowDownPetShopView.New()
	}
end

return ShowDownPetShopViewPresentor
