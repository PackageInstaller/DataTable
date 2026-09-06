-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/view/GuessBoxRuleViewPresentor.lua

module("logic.extensions.guessbox.view.GuessBoxRuleViewPresentor", package.seeall)

local GuessBoxRuleViewPresentor = class("GuessBoxRuleViewPresentor", ViewPresentor)

function GuessBoxRuleViewPresentor:ctor()
	GuessBoxRuleViewPresentor.super.ctor(self)
end

function GuessBoxRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GuessBoxRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/guessbox/guessboxruleview.prefab"
	}
end

function GuessBoxRuleViewPresentor:buildViews()
	return {
		GuessBoxRuleView.New()
	}
end

return GuessBoxRuleViewPresentor
