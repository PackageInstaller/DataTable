-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/view/DivineKingNuoYaInfiniteFightMainViewPresentor.lua

module("logic.extensions.divinekingnuoya.view.DivineKingNuoYaInfiniteFightMainViewPresentor", package.seeall)

local DivineKingNuoYaInfiniteFightMainViewPresentor = class("DivineKingNuoYaInfiniteFightMainViewPresentor", ViewPresentor)

function DivineKingNuoYaInfiniteFightMainViewPresentor:ctor()
	DivineKingNuoYaInfiniteFightMainViewPresentor.super.ctor(self)
end

function DivineKingNuoYaInfiniteFightMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingNuoYaInfiniteFightMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingnuoya/divinekingnuoyainfinitefightmainview.prefab"
	}
end

function DivineKingNuoYaInfiniteFightMainViewPresentor:buildViews()
	return {
		DivineKingNuoYaInfiniteFightMainView.New()
	}
end

return DivineKingNuoYaInfiniteFightMainViewPresentor
