-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/leila/LeilaRuleViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.leila.LeilaRuleViewPresentor", package.seeall)

local LeilaRuleViewPresentor = class("LeilaRuleViewPresentor", ViewPresentor)

function LeilaRuleViewPresentor:ctor()
	LeilaRuleViewPresentor.super.ctor(self)
end

function LeilaRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LeilaRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/leila/leilaruleview.prefab"
	}
end

function LeilaRuleViewPresentor:buildViews()
	return {
		LeilaRuleView.New()
	}
end

return LeilaRuleViewPresentor
