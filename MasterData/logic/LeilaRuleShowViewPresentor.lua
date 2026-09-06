-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/leila/LeilaRuleShowViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.leila.LeilaRuleShowViewPresentor", package.seeall)

local LeilaRuleShowViewPresentor = class("LeilaRuleShowViewPresentor", ViewPresentor)

function LeilaRuleShowViewPresentor:ctor()
	LeilaRuleShowViewPresentor.super.ctor(self)
end

function LeilaRuleShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LeilaRuleShowViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/anheimm/anheimmsperuleview.prefab"
	}
end

function LeilaRuleShowViewPresentor:buildViews()
	return {
		LeilaRuleShowView.New()
	}
end

return LeilaRuleShowViewPresentor
