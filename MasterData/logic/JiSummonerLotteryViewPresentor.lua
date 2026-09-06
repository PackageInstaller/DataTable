-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerLotteryViewPresentor.lua

module("logic.extensions.jisummoner.view.JiSummonerLotteryViewPresentor", package.seeall)

local JiSummonerLotteryViewPresentor = class("JiSummonerLotteryViewPresentor", ViewPresentor)

function JiSummonerLotteryViewPresentor:ctor()
	JiSummonerLotteryViewPresentor.super.ctor(self)
end

function JiSummonerLotteryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JiSummonerLotteryViewPresentor:dependWhatResources()
	return {
		"ui/views/jisummoner/jisummonerlotteryview.prefab"
	}
end

function JiSummonerLotteryViewPresentor:buildViews()
	return {
		JiSummonerLotteryView.New()
	}
end

return JiSummonerLotteryViewPresentor
