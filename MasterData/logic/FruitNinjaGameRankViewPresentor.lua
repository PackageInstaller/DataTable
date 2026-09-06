-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaGameRankViewPresentor.lua

module("logic.extensions.fruitninja.view.FruitNinjaGameRankViewPresentor", package.seeall)

local FruitNinjaGameRankViewPresentor = class("FruitNinjaGameRankViewPresentor", ViewPresentor)

function FruitNinjaGameRankViewPresentor:ctor()
	FruitNinjaGameRankViewPresentor.super.ctor(self)
end

function FruitNinjaGameRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FruitNinjaGameRankViewPresentor:dependWhatResources()
	return {
		"ui/views/fruitninja/fruitninjagamerankview.prefab"
	}
end

function FruitNinjaGameRankViewPresentor:buildViews()
	return {
		FruitNinjaGameRankView.New()
	}
end

return FruitNinjaGameRankViewPresentor
