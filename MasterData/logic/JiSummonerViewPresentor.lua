-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerViewPresentor.lua

module("logic.extensions.jisummoner.view.JiSummonerViewPresentor", package.seeall)

local JiSummonerViewPresentor = class("JiSummonerViewPresentor", ViewPresentor)

function JiSummonerViewPresentor:ctor()
	JiSummonerViewPresentor.super.ctor(self)
end

function JiSummonerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JiSummonerViewPresentor:dependWhatResources()
	return {
		"ui/views/jisummoner/jisummonerview.prefab"
	}
end

function JiSummonerViewPresentor:buildViews()
	return {
		JiSummonerView.New()
	}
end

return JiSummonerViewPresentor
