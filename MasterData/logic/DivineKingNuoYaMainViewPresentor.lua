-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingnuoya/view/DivineKingNuoYaMainViewPresentor.lua

module("logic.extensions.divinekingnuoya.view.DivineKingNuoYaMainViewPresentor", package.seeall)

local DivineKingNuoYaMainViewPresentor = class("DivineKingNuoYaMainViewPresentor", ViewPresentor)

function DivineKingNuoYaMainViewPresentor:ctor()
	DivineKingNuoYaMainViewPresentor.super.ctor(self)
end

function DivineKingNuoYaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineKingNuoYaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinekingnuoya/divinekingnuoyamainview.prefab"
	}
end

function DivineKingNuoYaMainViewPresentor:buildViews()
	return {
		DivineKingNuoYaMainView.New()
	}
end

return DivineKingNuoYaMainViewPresentor
