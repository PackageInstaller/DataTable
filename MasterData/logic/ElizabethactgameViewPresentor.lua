-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elizabethgame/view/ElizabethactgameViewPresentor.lua

module("logic.extensions.elizabethgame.view.ElizabethactgameViewPresentor", package.seeall)

local ElizabethactgameViewPresentor = class("ElizabethactgameViewPresentor", ViewPresentor)

function ElizabethactgameViewPresentor:ctor()
	ElizabethactgameViewPresentor.super.ctor(self)
end

function ElizabethactgameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElizabethactgameViewPresentor:dependWhatResources()
	return {
		"ui/views/elizabethgame/elizabethactgameview.prefab"
	}
end

function ElizabethactgameViewPresentor:buildViews()
	return {
		ElizabethactgameView.New()
	}
end

return ElizabethactgameViewPresentor
