-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleRankViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleRankViewPresentor", package.seeall)

local StarBattleRankViewPresentor = class("StarBattleRankViewPresentor", ViewPresentor)

function StarBattleRankViewPresentor:ctor()
	StarBattleRankViewPresentor.super.ctor(self)
end

function StarBattleRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleRankViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattlerankview.prefab"
	}
end

function StarBattleRankViewPresentor:buildViews()
	return {
		StarBattleRankView.New()
	}
end

function StarBattleRankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return StarBattleRankViewPresentor
