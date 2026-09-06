-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godaruishichallenge/view/GodARuiShiChallengeRuleViewPresentor.lua

module("logic.extensions.godaruishichallenge.view.GodARuiShiChallengeRuleViewPresentor", package.seeall)

local GodARuiShiChallengeRuleViewPresentor = class("GodARuiShiChallengeRuleViewPresentor", ViewPresentor)

function GodARuiShiChallengeRuleViewPresentor:ctor()
	GodARuiShiChallengeRuleViewPresentor.super.ctor(self)
end

function GodARuiShiChallengeRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GodARuiShiChallengeRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/godaruishichallenge/godaruishichallengeruleview.prefab"
	}
end

function GodARuiShiChallengeRuleViewPresentor:buildViews()
	return {
		GodARuiShiChallengeRuleView.New()
	}
end

function GodARuiShiChallengeRuleViewPresentor:onClickOutside()
	self:close()
end

return GodARuiShiChallengeRuleViewPresentor
