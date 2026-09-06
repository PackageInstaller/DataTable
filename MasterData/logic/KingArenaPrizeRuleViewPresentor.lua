-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingarena/view/prize/KingArenaPrizeRuleViewPresentor.lua

module("logic.extensions.kingarena.view.prize.KingArenaPrizeRuleViewPresentor", package.seeall)

local KingArenaPrizeRuleViewPresentor = class("KingArenaPrizeRuleViewPresentor", ViewPresentor)

function KingArenaPrizeRuleViewPresentor:ctor()
	KingArenaPrizeRuleViewPresentor.super.ctor(self)
end

function KingArenaPrizeRuleViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function KingArenaPrizeRuleViewPresentor:dependWhatResources()
	return {
		"ui/views/kingarena/prize/kingarenaprizeruleview.prefab"
	}
end

function KingArenaPrizeRuleViewPresentor:buildViews()
	return {
		KingArenaPrizeRuleView.New()
	}
end

function KingArenaPrizeRuleViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return KingArenaPrizeRuleViewPresentor
