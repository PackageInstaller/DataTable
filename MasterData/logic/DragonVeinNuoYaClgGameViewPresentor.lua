-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonveinnuoyaclg/view/DragonVeinNuoYaClgGameViewPresentor.lua

module("logic.extensions.dragonveinnuoyaclg.view.DragonVeinNuoYaClgGameViewPresentor", package.seeall)

local DragonVeinNuoYaClgGameViewPresentor = class("DragonVeinNuoYaClgGameViewPresentor", ViewPresentor)

function DragonVeinNuoYaClgGameViewPresentor:ctor()
	DragonVeinNuoYaClgGameViewPresentor.super.ctor(self)
end

function DragonVeinNuoYaClgGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonVeinNuoYaClgGameViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonveinnuoyaclg/dragonveinnuoyaclggameview.prefab"
	}
end

function DragonVeinNuoYaClgGameViewPresentor:buildViews()
	return {
		DragonVeinNuoYaClgGameView.New()
	}
end

return DragonVeinNuoYaClgGameViewPresentor
