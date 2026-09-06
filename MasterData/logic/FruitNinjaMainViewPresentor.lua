-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fruitninja/view/FruitNinjaMainViewPresentor.lua

module("logic.extensions.fruitninja.view.FruitNinjaMainViewPresentor", package.seeall)

local FruitNinjaMainViewPresentor = class("FruitNinjaMainViewPresentor", ViewPresentor)

function FruitNinjaMainViewPresentor:ctor()
	FruitNinjaMainViewPresentor.super.ctor(self)
end

function FruitNinjaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FruitNinjaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/fruitninja/fruitninjamainview.prefab"
	}
end

function FruitNinjaMainViewPresentor:buildViews()
	return {
		FruitNinjaMainView.New()
	}
end

return FruitNinjaMainViewPresentor
