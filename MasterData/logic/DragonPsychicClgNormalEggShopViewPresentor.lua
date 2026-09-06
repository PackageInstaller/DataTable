-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalEggShopViewPresentor.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalEggShopViewPresentor", package.seeall)

local DragonPsychicClgNormalEggShopViewPresentor = class("DragonPsychicClgNormalEggShopViewPresentor", ViewPresentor)

function DragonPsychicClgNormalEggShopViewPresentor:ctor()
	DragonPsychicClgNormalEggShopViewPresentor.super.ctor(self)
end

function DragonPsychicClgNormalEggShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonPsychicClgNormalEggShopViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonpsychicclg/dragonpsychicclgnormaleggshopview.prefab"
	}
end

function DragonPsychicClgNormalEggShopViewPresentor:buildViews()
	return {
		DragonPsychicClgNormalEggShopView.New()
	}
end

return DragonPsychicClgNormalEggShopViewPresentor
