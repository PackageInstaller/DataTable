-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/view/SlackOffGameViewPresentor.lua

module("logic.extensions.slackoffgame.view.SlackOffGameViewPresentor", package.seeall)

local SlackOffGameViewPresentor = class("SlackOffGameViewPresentor", ViewPresentor)

function SlackOffGameViewPresentor:ctor()
	SlackOffGameViewPresentor.super.ctor(self)
end

function SlackOffGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SlackOffGameViewPresentor:dependWhatResources()
	return {
		"ui/views/slackoffgame/slackoffgameview.prefab"
	}
end

function SlackOffGameViewPresentor:buildViews()
	return {
		SlackOffGameView.New()
	}
end

return SlackOffGameViewPresentor
