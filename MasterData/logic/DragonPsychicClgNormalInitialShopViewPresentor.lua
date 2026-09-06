-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpsychicclg/view/DragonPsychicClgNormalInitialShopViewPresentor.lua

module("logic.extensions.dragonpsychicclg.view.DragonPsychicClgNormalInitialShopViewPresentor", package.seeall)

local DragonPsychicClgNormalInitialShopViewPresentor = class("DragonPsychicClgNormalInitialShopViewPresentor", ViewPresentor)

function DragonPsychicClgNormalInitialShopViewPresentor:ctor()
	DragonPsychicClgNormalInitialShopViewPresentor.super.ctor(self)
end

function DragonPsychicClgNormalInitialShopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonPsychicClgNormalInitialShopViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonpsychicclg/dragonpsychicclgnormalinitialshopview.prefab"
	}
end

function DragonPsychicClgNormalInitialShopViewPresentor:buildViews()
	return {
		DragonPsychicClgNormalInitialShopView.New()
	}
end

return DragonPsychicClgNormalInitialShopViewPresentor
