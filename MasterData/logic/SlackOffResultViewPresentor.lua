-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/view/SlackOffResultViewPresentor.lua

module("logic.extensions.slackoffgame.view.SlackOffResultViewPresentor", package.seeall)

local SlackOffResultViewPresentor = class("SlackOffResultViewPresentor", ViewPresentor)

function SlackOffResultViewPresentor:ctor()
	SlackOffResultViewPresentor.super.ctor(self)
end

function SlackOffResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SlackOffResultViewPresentor:dependWhatResources()
	return {
		"ui/views/slackoffgame/slackoffresultview.prefab"
	}
end

function SlackOffResultViewPresentor:buildViews()
	return {
		SlackOffResultView.New()
	}
end

function SlackOffResultViewPresentor:onClickOutside()
	for i, v in ipairs(self._views) do
		if v.__cname == "SlackOffResultView" then
			v:sendEndAndClose()

			break
		end
	end
end

return SlackOffResultViewPresentor
