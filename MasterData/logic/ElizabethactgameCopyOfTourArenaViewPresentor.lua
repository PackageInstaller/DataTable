-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/elizabeth/ElizabethactgameCopyOfTourArenaViewPresentor.lua

module("logic.extensions.tourarena.view.copy.elizabeth.ElizabethactgameViewPresentor", package.seeall)

local ElizabethactgameViewPresentor = class("ElizabethactgameViewPresentor", ViewPresentor)

function ElizabethactgameViewPresentor:ctor()
	ElizabethactgameViewPresentor.super.ctor(self)
end

function ElizabethactgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElizabethactgameViewPresentor:dependWhatResources()
	return {
		"ui/views/tourarena/game/elizabethactgamecopyoftourarenaview.prefab"
	}
end

function ElizabethactgameViewPresentor:buildViews()
	return {
		ElizabethactgameCopyOfTourArenaView.New()
	}
end

return ElizabethactgameViewPresentor
