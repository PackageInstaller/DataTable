-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldGameViewPresentor.lua

module("logic.extensions.uniqueworld.view.UniqueWorldGameViewPresentor", package.seeall)

local UniqueWorldGameViewPresentor = class("UniqueWorldGameViewPresentor", ViewPresentor)

function UniqueWorldGameViewPresentor:ctor()
	UniqueWorldGameViewPresentor.super.ctor(self)
end

function UniqueWorldGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UniqueWorldGameViewPresentor:dependWhatResources()
	return {
		"ui/views/uniqueworld/uniqueworldgameview.prefab"
	}
end

function UniqueWorldGameViewPresentor:buildViews()
	return {
		UniqueWorldGameView.New()
	}
end

return UniqueWorldGameViewPresentor
