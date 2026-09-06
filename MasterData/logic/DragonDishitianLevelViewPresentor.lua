-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/view/DragonDishitianLevelViewPresentor.lua

module("logic.extensions.dragondishitian.view.DragonDishitianLevelViewPresentor", package.seeall)

local DragonDishitianLevelViewPresentor = class("DragonDishitianLevelViewPresentor", ViewPresentor)

function DragonDishitianLevelViewPresentor:ctor()
	DragonDishitianLevelViewPresentor.super.ctor(self)
end

function DragonDishitianLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonDishitianLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/dragondishitian/dragondishitianlevelview.prefab",
		DragonDishitianController.StarMapPath
	}
end

function DragonDishitianLevelViewPresentor:buildViews()
	return {
		DragonDishitianLevelView.New()
	}
end

return DragonDishitianLevelViewPresentor
