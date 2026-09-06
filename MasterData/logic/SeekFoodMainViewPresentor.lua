-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/view/SeekFoodMainViewPresentor.lua

module("logic.extensions.seekfood.view.SeekFoodMainViewPresentor", package.seeall)

local SeekFoodMainViewPresentor = class("SeekFoodMainViewPresentor", ViewPresentor)

function SeekFoodMainViewPresentor:ctor()
	SeekFoodMainViewPresentor.super.ctor(self)
end

function SeekFoodMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SeekFoodMainViewPresentor:dependWhatResources()
	return {
		"ui/views/seekfood/seekfoodmainview.prefab"
	}
end

function SeekFoodMainViewPresentor:buildViews()
	return {
		SeekFoodMainView.New()
	}
end

return SeekFoodMainViewPresentor
