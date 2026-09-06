-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerTaskViewPresentor.lua

module("logic.extensions.jisummoner.view.JiSummonerTaskViewPresentor", package.seeall)

local JiSummonerTaskViewPresentor = class("JiSummonerTaskViewPresentor", ViewPresentor)

function JiSummonerTaskViewPresentor:ctor()
	JiSummonerTaskViewPresentor.super.ctor(self)
end

function JiSummonerTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JiSummonerTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/jisummoner/jisummonertaskview.prefab"
	}
end

function JiSummonerTaskViewPresentor:buildViews()
	return {
		JiSummonerTaskView.New()
	}
end

return JiSummonerTaskViewPresentor
