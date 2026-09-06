-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleDefPrizeViewPresentor.lua

module("logic.extensions.starbattle.view.StarBattleDefPrizeViewPresentor", package.seeall)

local StarBattleDefPrizeViewPresentor = class("StarBattleDefPrizeViewPresentor", ViewPresentor)

function StarBattleDefPrizeViewPresentor:ctor()
	StarBattleDefPrizeViewPresentor.super.ctor(self)
end

function StarBattleDefPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function StarBattleDefPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/starbattle/starbattledefprizeview.prefab"
	}
end

function StarBattleDefPrizeViewPresentor:buildViews()
	return {
		StarBattleDefPrizeView.New()
	}
end

return StarBattleDefPrizeViewPresentor
