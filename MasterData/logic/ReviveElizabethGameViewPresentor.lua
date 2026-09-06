-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/view/ReviveElizabethGameViewPresentor.lua

module("logic.extensions.reviveelizabeth.view.ReviveElizabethGameViewPresentor", package.seeall)

local ReviveElizabethGameViewPresentor = class("ReviveElizabethGameViewPresentor", ViewPresentor)

function ReviveElizabethGameViewPresentor:ctor()
	ReviveElizabethGameViewPresentor.super.ctor(self)
end

function ReviveElizabethGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ReviveElizabethGameViewPresentor:dependWhatResources()
	return {
		"ui/views/reviveelizabeth/reviveelizabethgameview.prefab"
	}
end

function ReviveElizabethGameViewPresentor:buildViews()
	return {
		ReviveElizabethGameView.New()
	}
end

return ReviveElizabethGameViewPresentor
