-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchRankViewPresentor.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchRankViewPresentor", package.seeall)

local TianYanMatchRankViewPresentor = class("TianYanMatchRankViewPresentor", ViewPresentor)

function TianYanMatchRankViewPresentor:ctor()
	TianYanMatchRankViewPresentor.super.ctor(self)
end

function TianYanMatchRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianYanMatchRankViewPresentor:dependWhatResources()
	return {
		"ui/views/tianyanmatch/tianyanmatchrankview.prefab"
	}
end

function TianYanMatchRankViewPresentor:buildViews()
	return {
		TianYanMatchRankView.New()
	}
end

return TianYanMatchRankViewPresentor
