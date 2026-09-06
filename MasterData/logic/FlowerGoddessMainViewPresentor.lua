-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flowergoddess/view/FlowerGoddessMainViewPresentor.lua

module("logic.extensions.flowergoddess.view.FlowerGoddessMainViewPresentor", package.seeall)

local FlowerGoddessMainViewPresentor = class("FlowerGoddessMainViewPresentor", ViewPresentor)

function FlowerGoddessMainViewPresentor:ctor()
	FlowerGoddessMainViewPresentor.super.ctor(self)
end

function FlowerGoddessMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FlowerGoddessMainViewPresentor:dependWhatResources()
	return {
		"ui/views/flowergoddess/flowergoddessmainview.prefab"
	}
end

function FlowerGoddessMainViewPresentor:buildViews()
	return {
		FlowerGoddessMainView.New()
	}
end

return FlowerGoddessMainViewPresentor
