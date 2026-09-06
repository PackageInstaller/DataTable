-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/view/SeekFoodFoodDisViewPresentor.lua

module("logic.extensions.seekfood.view.SeekFoodFoodDisViewPresentor", package.seeall)

local SeekFoodFoodDisViewPresentor = class("SeekFoodFoodDisViewPresentor", ViewPresentor)

function SeekFoodFoodDisViewPresentor:ctor()
	SeekFoodFoodDisViewPresentor.super.ctor(self)
end

function SeekFoodFoodDisViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeekFoodFoodDisViewPresentor:dependWhatResources()
	return {
		"ui/views/seekfood/seekfoodfooddisview.prefab"
	}
end

function SeekFoodFoodDisViewPresentor:buildViews()
	return {
		SeekFoodFoodDisView.New()
	}
end

return SeekFoodFoodDisViewPresentor
