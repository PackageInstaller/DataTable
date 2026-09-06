-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/guangyuansushi/GuangYuanSuShiRuleShowViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.guangyuansushi.GuangYuanSuShiRuleShowViewPresentor", package.seeall)

local GuangYuanSuShiRuleShowViewPresentor = class("GuangYuanSuShiRuleShowViewPresentor", ViewPresentor)

function GuangYuanSuShiRuleShowViewPresentor:ctor()
	GuangYuanSuShiRuleShowViewPresentor.super.ctor(self)
end

function GuangYuanSuShiRuleShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuangYuanSuShiRuleShowViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/guangyuansushi/guangyuansushisperuleview.prefab"
	}
end

function GuangYuanSuShiRuleShowViewPresentor:buildViews()
	return {
		GuangYuanSuShiRuleShowView.New()
	}
end

return GuangYuanSuShiRuleShowViewPresentor
