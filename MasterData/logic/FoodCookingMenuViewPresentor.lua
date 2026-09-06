-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/view/FoodCookingMenuViewPresentor.lua

module("logic.extensions.celebratebirthday.view.FoodCookingMenuViewPresentor", package.seeall)

local FoodCookingMenuViewPresentor = class("FoodCookingMenuViewPresentor", ViewPresentor)

function FoodCookingMenuViewPresentor:ctor()
	FoodCookingMenuViewPresentor.super.ctor(self)
end

function FoodCookingMenuViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FoodCookingMenuViewPresentor:dependWhatResources()
	return {
		"ui/views/celebratebirthday/foodcookingmenuview.prefab"
	}
end

function FoodCookingMenuViewPresentor:buildViews()
	return {
		FoodCookingMenuView.New()
	}
end

return FoodCookingMenuViewPresentor
