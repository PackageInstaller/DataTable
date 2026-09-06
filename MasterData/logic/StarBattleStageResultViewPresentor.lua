-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleStageResultViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleStageResultViewPresentor", package.seeall)

local StarBattleStageResultViewPresentor = class("StarBattleStageResultViewPresentor", ViewPresentor)

function StarBattleStageResultViewPresentor:ctor()
	StarBattleStageResultViewPresentor.super.ctor(self)
end

function StarBattleStageResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleStageResultViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattlestageresultview.prefab"
	}
end

function StarBattleStageResultViewPresentor:buildViews()
	return {
		StarBattleStageResultView.New()
	}
end

return StarBattleStageResultViewPresentor
