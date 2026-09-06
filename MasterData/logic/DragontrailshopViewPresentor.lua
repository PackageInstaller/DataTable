-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/view/DragontrailshopViewPresentor.lua

module("logic.extensions.dragontrial.view.DragontrailshopViewPresentor", package.seeall)

local DragontrailshopViewPresentor = class("DragontrailshopViewPresentor", ViewPresentor)

function DragontrailshopViewPresentor:ctor()
	DragontrailshopViewPresentor.super.ctor(self)
end

function DragontrailshopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragontrailshopViewPresentor:dependWhatResources()
	return {
		"ui/views/dragontrial/dragontrailshopview.prefab"
	}
end

function DragontrailshopViewPresentor:buildViews()
	return {
		DragontrailshopView.New()
	}
end

return DragontrailshopViewPresentor
