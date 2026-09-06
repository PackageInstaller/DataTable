-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seekfood/view/SeekFoodBookViewPresentor.lua

module("logic.extensions.seekfood.view.SeekFoodBookViewPresentor", package.seeall)

local SeekFoodBookViewPresentor = class("SeekFoodBookViewPresentor", ViewPresentor)

function SeekFoodBookViewPresentor:ctor()
	SeekFoodBookViewPresentor.super.ctor(self)
end

function SeekFoodBookViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function SeekFoodBookViewPresentor:dependWhatResources()
	return {
		"ui/views/seekfood/seekfoodbookview.prefab"
	}
end

function SeekFoodBookViewPresentor:buildViews()
	return {
		SeekFoodBookView.New()
	}
end

return SeekFoodBookViewPresentor
