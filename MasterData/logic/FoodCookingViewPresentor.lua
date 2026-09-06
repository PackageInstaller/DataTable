-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/view/FoodCookingViewPresentor.lua

module("logic.extensions.celebratebirthday.view.FoodCookingViewPresentor", package.seeall)

local FoodCookingViewPresentor = class("FoodCookingViewPresentor", ViewPresentor)

function FoodCookingViewPresentor:ctor()
	FoodCookingViewPresentor.super.ctor(self)
end

function FoodCookingViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FoodCookingViewPresentor:dependWhatResources()
	return {
		"ui/views/celebratebirthday/foodcookingview.prefab"
	}
end

function FoodCookingViewPresentor:buildViews()
	return {
		FoodCookingView.New()
	}
end

return FoodCookingViewPresentor
