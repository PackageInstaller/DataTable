-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/FlipGameStartViewPresentor.lua

module("logic.extensions.dreamteam.view.FlipGameStartViewPresentor", package.seeall)

local FlipGameStartViewPresentor = class("FlipGameStartViewPresentor", ViewPresentor)

function FlipGameStartViewPresentor:ctor()
	FlipGameStartViewPresentor.super.ctor(self)
end

function FlipGameStartViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function FlipGameStartViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteam/smallgame/flipgamestartview.prefab"
	}
end

function FlipGameStartViewPresentor:buildViews()
	return {
		FlipGameStartView.New()
	}
end

return FlipGameStartViewPresentor
