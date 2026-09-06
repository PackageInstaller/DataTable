-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domainadventure/view/DomAdvEventGameViewPresentor.lua

module("logic.extensions.domainadventure.view.DomAdvEventGameViewPresentor", package.seeall)

local DomAdvEventGameViewPresentor = class("DomAdvEventGameViewPresentor", ViewPresentor)

function DomAdvEventGameViewPresentor:ctor()
	DomAdvEventGameViewPresentor.super.ctor(self)
end

function DomAdvEventGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DomAdvEventGameViewPresentor:dependWhatResources()
	return {
		"ui/views/domainadventure/domadveventgameview.prefab"
	}
end

function DomAdvEventGameViewPresentor:buildViews()
	return {
		DomAdvEventGameView.New()
	}
end

return DomAdvEventGameViewPresentor
