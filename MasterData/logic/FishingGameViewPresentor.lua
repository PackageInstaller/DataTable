-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/view/FishingGameViewPresentor.lua

module("logic.extensions.fishinggame.view.FishingGameViewPresentor", package.seeall)

local FishingGameViewPresentor = class("FishingGameViewPresentor", ViewPresentor)

function FishingGameViewPresentor:ctor()
	FishingGameViewPresentor.super.ctor(self)
end

function FishingGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FishingGameViewPresentor:dependWhatResources()
	return {
		"ui/views/fishinggame/fishinggameview.prefab"
	}
end

function FishingGameViewPresentor:buildViews()
	return {
		FishingGameView.New()
	}
end

return FishingGameViewPresentor
