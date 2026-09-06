-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaResultViewPresentor.lua

module("logic.extensions.fruitninja.view.FruitNinjaResultViewPresentor", package.seeall)

local FruitNinjaResultViewPresentor = class("FruitNinjaResultViewPresentor", ViewPresentor)

function FruitNinjaResultViewPresentor:ctor()
	FruitNinjaResultViewPresentor.super.ctor(self)
end

function FruitNinjaResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FruitNinjaResultViewPresentor:dependWhatResources()
	return {
		"ui/views/fruitninja/fruitninjaresultview.prefab"
	}
end

function FruitNinjaResultViewPresentor:buildViews()
	return {
		FruitNinjaResultView.New()
	}
end

return FruitNinjaResultViewPresentor
