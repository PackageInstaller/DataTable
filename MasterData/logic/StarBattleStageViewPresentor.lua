-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleStageViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleStageViewPresentor", package.seeall)

local StarBattleStageViewPresentor = class("StarBattleStageViewPresentor", ViewPresentor)

function StarBattleStageViewPresentor:ctor()
	StarBattleStageViewPresentor.super.ctor(self)
end

function StarBattleStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleStageViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattlestageview.prefab"
	}
end

function StarBattleStageViewPresentor:buildViews()
	return {
		StarBattleStageView.New()
	}
end

function StarBattleStageViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StarBattleStageViewPresentor
