-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleRankMainViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleRankMainViewPresentor", package.seeall)

local StarBattleRankMainViewPresentor = class("StarBattleRankMainViewPresentor", ViewPresentor)

function StarBattleRankMainViewPresentor:ctor()
	StarBattleRankMainViewPresentor.super.ctor(self)
end

function StarBattleRankMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleRankMainViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattlerankmainview.prefab"
	}
end

function StarBattleRankMainViewPresentor:buildViews()
	return {
		StarBattleRankMainView.New()
	}
end

return StarBattleRankMainViewPresentor
