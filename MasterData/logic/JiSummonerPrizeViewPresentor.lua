-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerPrizeViewPresentor.lua

module("logic.extensions.jisummoner.view.JiSummonerPrizeViewPresentor", package.seeall)

local JiSummonerPrizeViewPresentor = class("JiSummonerPrizeViewPresentor", ViewPresentor)

function JiSummonerPrizeViewPresentor:ctor()
	JiSummonerPrizeViewPresentor.super.ctor(self)
end

function JiSummonerPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JiSummonerPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/jisummoner/jisummonerprizeview.prefab"
	}
end

function JiSummonerPrizeViewPresentor:buildViews()
	return {
		JiSummonerPrizeView.New()
	}
end

return JiSummonerPrizeViewPresentor
