-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongRuleViewPresentor.lua

module("logic.extensions.tongbattle.view.TongRuleViewPresentor", package.seeall)

local TongRuleViewPresentor = class("TongRuleViewPresentor", ViewWithGuidePresentor)

function TongRuleViewPresentor:ctor()
	TongRuleViewPresentor.super.ctor(self)
end

function TongRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function TongRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/tongbattle/tongruleview.prefab"
	}
end

function TongRuleViewPresentor:buildViews()
	return {
		TongRuleView.New()
	}
end

return TongRuleViewPresentor
