-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gamelobby/view/GameLobbyViewPresentor.lua

module("logic.extensions.gamelobby.view.GameLobbyViewPresentor", package.seeall)

local GameLobbyViewPresentor = class("GameLobbyViewPresentor", ViewPresentor)

function GameLobbyViewPresentor:ctor()
	GameLobbyViewPresentor.super.ctor(self)
end

function GameLobbyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GameLobbyViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/gamelobbyview.prefab"
	}
end

function GameLobbyViewPresentor:buildViews()
	return {
		GameLobbyView.New()
	}
end

return GameLobbyViewPresentor
