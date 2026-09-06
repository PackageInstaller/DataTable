-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/idlegame/view/IdleGameViewPresentor.lua

module("logic.extensions.idlegame.view.IdleGameViewPresentor", package.seeall)

local IdleGameViewPresentor = class("IdleGameViewPresentor", ViewWithGuidePresentor)

function IdleGameViewPresentor:ctor()
	IdleGameViewPresentor.super.ctor(self)
end

function IdleGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function IdleGameViewPresentor:dependWhatResources()
	return {
		"ui/views/idlegame/idlegameview.prefab"
	}
end

function IdleGameViewPresentor:buildViews()
	return {
		IdleGameView.New(),
		IdleTipsView.New()
	}
end

return IdleGameViewPresentor
