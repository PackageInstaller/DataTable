-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yirenpozhen/view/HexagramruleViewPresentor.lua

module("logic.extensions.yirenpozhen.view.HexagramruleViewPresentor", package.seeall)

local HexagramruleViewPresentor = class("HexagramruleViewPresentor", ViewPresentor)

function HexagramruleViewPresentor:ctor()
	HexagramruleViewPresentor.super.ctor(self)
end

function HexagramruleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HexagramruleViewPresentor:dependWhatResources()
	return {
		"ui/views/yirenpozhen/hexagramruleview.prefab"
	}
end

function HexagramruleViewPresentor:buildViews()
	return {
		HexagramRuleView.New()
	}
end

return HexagramruleViewPresentor
