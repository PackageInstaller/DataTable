-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/view/DragonDishitianClgViewPresentor.lua

module("logic.extensions.dragondishitian.view.DragonDishitianClgViewPresentor", package.seeall)

local DragonDishitianClgViewPresentor = class("DragonDishitianClgViewPresentor", ViewPresentor)

function DragonDishitianClgViewPresentor:ctor()
	DragonDishitianClgViewPresentor.super.ctor(self)
end

function DragonDishitianClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DragonDishitianClgViewPresentor:dependWhatResources()
	return {
		"ui/views/dragondishitian/dragondishitianclgview.prefab",
		DragonDishitianController.StarMapPath,
		DragonDishitianController.ChildStarMapPath
	}
end

function DragonDishitianClgViewPresentor:buildViews()
	return {
		DragonDishitianClgView.New()
	}
end

return DragonDishitianClgViewPresentor
