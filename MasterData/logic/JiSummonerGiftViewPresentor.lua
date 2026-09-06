-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerGiftViewPresentor.lua

module("logic.extensions.jisummoner.view.JiSummonerGiftViewPresentor", package.seeall)

local JiSummonerGiftViewPresentor = class("JiSummonerGiftViewPresentor", ViewPresentor)

function JiSummonerGiftViewPresentor:ctor()
	JiSummonerGiftViewPresentor.super.ctor(self)
end

function JiSummonerGiftViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function JiSummonerGiftViewPresentor:dependWhatResources()
	return {
		"ui/views/jisummoner/jisummonergiftview.prefab"
	}
end

function JiSummonerGiftViewPresentor:buildViews()
	return {
		JiSummonerGiftView.New()
	}
end

return JiSummonerGiftViewPresentor
