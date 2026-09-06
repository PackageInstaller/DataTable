-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaBuffViewPresentor.lua

module("logic.extensions.fruitninja.view.FruitNinjaBuffViewPresentor", package.seeall)

local FruitNinjaBuffViewPresentor = class("FruitNinjaBuffViewPresentor", ViewPresentor)

function FruitNinjaBuffViewPresentor:ctor()
	FruitNinjaBuffViewPresentor.super.ctor(self)
end

function FruitNinjaBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FruitNinjaBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/fruitninja/fruitninjabuffview.prefab"
	}
end

function FruitNinjaBuffViewPresentor:buildViews()
	return {
		FruitNinjaBuffView.New()
	}
end

return FruitNinjaBuffViewPresentor
