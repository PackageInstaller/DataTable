-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/game/duolamm/CopyDuolaGameViewPresentor.lua

module("logic.extensions.suppressgame.view.game.duolamm.CopyDuolaGameViewPresentor", package.seeall)

local CopyDuolaGameViewPresentor = class("CopyDuolaGameViewPresentor", ViewPresentor)

function CopyDuolaGameViewPresentor:ctor()
	CopyDuolaGameViewPresentor.super.ctor(self)
end

function CopyDuolaGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CopyDuolaGameViewPresentor:dependWhatResources()
	return {
		"ui/views/duolamengmeng/duolagameview.prefab"
	}
end

function CopyDuolaGameViewPresentor:buildViews()
	return {
		CopyDuolaGameView.New()
	}
end

return CopyDuolaGameViewPresentor
