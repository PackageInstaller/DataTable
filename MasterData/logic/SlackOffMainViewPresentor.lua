-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/view/SlackOffMainViewPresentor.lua

module("logic.extensions.slackoffgame.view.SlackOffMainViewPresentor", package.seeall)

local SlackOffMainViewPresentor = class("SlackOffMainViewPresentor", ViewPresentor)

function SlackOffMainViewPresentor:ctor()
	SlackOffMainViewPresentor.super.ctor(self)
end

function SlackOffMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SlackOffMainViewPresentor:dependWhatResources()
	return {
		"ui/views/slackoffgame/slackoffmainview.prefab"
	}
end

function SlackOffMainViewPresentor:buildViews()
	return {
		SlackOffMainView.New()
	}
end

return SlackOffMainViewPresentor
