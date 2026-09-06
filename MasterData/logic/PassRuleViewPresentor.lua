-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/PassRuleViewPresentor.lua

module("logic.extensions.mission.view.PassRuleViewPresentor", package.seeall)

local PassRuleViewPresentor = class("PassRuleViewPresentor", ViewWithGuidePresentor)

function PassRuleViewPresentor:ctor()
	PassRuleViewPresentor.super.ctor(self)
end

function PassRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function PassRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/passruleview.prefab"
	}
end

function PassRuleViewPresentor:buildViews()
	return {
		PassRuleView.New()
	}
end

return PassRuleViewPresentor
