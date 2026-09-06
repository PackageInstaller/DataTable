-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonveinnuoyaclg/view/DragonVeinNuoYaClgMainViewPresentor.lua

module("logic.extensions.dragonveinnuoyaclg.view.DragonVeinNuoYaClgMainViewPresentor", package.seeall)

local DragonVeinNuoYaClgMainViewPresentor = class("DragonVeinNuoYaClgMainViewPresentor", ViewPresentor)

function DragonVeinNuoYaClgMainViewPresentor:ctor()
	DragonVeinNuoYaClgMainViewPresentor.super.ctor(self)
end

function DragonVeinNuoYaClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonVeinNuoYaClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragonveinnuoyaclg/dragonveinnuoyaclgmainview.prefab"
	}
end

function DragonVeinNuoYaClgMainViewPresentor:buildViews()
	return {
		DragonVeinNuoYaClgMainView.New()
	}
end

return DragonVeinNuoYaClgMainViewPresentor
