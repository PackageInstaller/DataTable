-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flowergoddess/view/FlowerPopViewPresentor.lua

module("logic.extensions.flowergoddess.view.FlowerPopViewPresentor", package.seeall)

local FlowerPopViewPresentor = class("FlowerPopViewPresentor", ViewPresentor)

function FlowerPopViewPresentor:ctor()
	FlowerPopViewPresentor.super.ctor(self)
end

function FlowerPopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FlowerPopViewPresentor:dependWhatResources()
	return {
		"ui/views/flowergoddess/flowerpopview.prefab"
	}
end

function FlowerPopViewPresentor:buildViews()
	return {
		FlowerPopView.New()
	}
end

return FlowerPopViewPresentor
