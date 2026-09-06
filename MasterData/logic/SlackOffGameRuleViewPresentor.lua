-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/view/SlackOffGameRuleViewPresentor.lua

module("logic.extensions.slackoffgame.view.SlackOffGameRuleViewPresentor", package.seeall)

local SlackOffGameRuleViewPresentor = class("SlackOffGameRuleViewPresentor", ViewPresentor)

function SlackOffGameRuleViewPresentor:ctor()
	SlackOffGameRuleViewPresentor.super.ctor(self)
end

function SlackOffGameRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SlackOffGameRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/slackoffgame/slackoffgameruleview.prefab"
	}
end

function SlackOffGameRuleViewPresentor:buildViews()
	return {
		SlackOffGameRuleView.New()
	}
end

return SlackOffGameRuleViewPresentor
