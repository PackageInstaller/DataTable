-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerBuyViewPresentor.lua

module("logic.extensions.jisummoner.view.JiSummonerBuyViewPresentor", package.seeall)

local JiSummonerBuyViewPresentor = class("JiSummonerBuyViewPresentor", ViewPresentor)

function JiSummonerBuyViewPresentor:ctor()
	JiSummonerBuyViewPresentor.super.ctor(self)
end

function JiSummonerBuyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JiSummonerBuyViewPresentor:dependWhatResources()
	return {
		"ui/views/jisummoner/jisummonerbuyview.prefab"
	}
end

function JiSummonerBuyViewPresentor:buildViews()
	return {
		JiSummonerBuyView.New()
	}
end

return JiSummonerBuyViewPresentor
