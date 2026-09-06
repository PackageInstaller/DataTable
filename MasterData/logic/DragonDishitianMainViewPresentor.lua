-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/view/DragonDishitianMainViewPresentor.lua

module("logic.extensions.dragondishitian.view.DragonDishitianMainViewPresentor", package.seeall)

local DragonDishitianMainViewPresentor = class("DragonDishitianMainViewPresentor", ViewPresentor)

function DragonDishitianMainViewPresentor:ctor()
	DragonDishitianMainViewPresentor.super.ctor(self)
end

function DragonDishitianMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonDishitianMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dragondishitian/dragondishitianmainview.prefab"
	}
end

function DragonDishitianMainViewPresentor:buildViews()
	return {
		DragonDishitianMainView.New()
	}
end

return DragonDishitianMainViewPresentor
