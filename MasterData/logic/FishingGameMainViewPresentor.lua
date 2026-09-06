-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/view/FishingGameMainViewPresentor.lua

module("logic.extensions.fishinggame.view.FishingGameMainViewPresentor", package.seeall)

local FishingGameMainViewPresentor = class("FishingGameMainViewPresentor", ViewPresentor)

function FishingGameMainViewPresentor:ctor()
	FishingGameMainViewPresentor.super.ctor(self)
end

function FishingGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FishingGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/fishinggame/fishinggamemainview.prefab"
	}
end

function FishingGameMainViewPresentor:buildViews()
	return {
		FishingGameMainView.New()
	}
end

return FishingGameMainViewPresentor
