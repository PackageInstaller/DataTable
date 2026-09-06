-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleRuleViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleRuleViewPresentor", package.seeall)

local ScuffleRuleViewPresentor = class("ScuffleRuleViewPresentor", ViewPresentor)

function ScuffleRuleViewPresentor:ctor()
	ScuffleRuleViewPresentor.super.ctor(self)
end

function ScuffleRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scuffleruleview.prefab"
	}
end

function ScuffleRuleViewPresentor:buildViews()
	return {
		ScuffleRuleView.New()
	}
end

return ScuffleRuleViewPresentor
