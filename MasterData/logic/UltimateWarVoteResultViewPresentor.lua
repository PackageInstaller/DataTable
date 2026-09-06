-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarVoteResultViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarVoteResultViewPresentor", package.seeall)

local UltimateWarVoteResultViewPresentor = class("UltimateWarVoteResultViewPresentor", ViewPresentor)

function UltimateWarVoteResultViewPresentor:ctor()
	UltimateWarVoteResultViewPresentor.super.ctor(self)
end

function UltimateWarVoteResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarVoteResultViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewarvoteresultview.prefab"
	}
end

function UltimateWarVoteResultViewPresentor:buildViews()
	return {
		UltimateWarVoteResultView.New()
	}
end

return UltimateWarVoteResultViewPresentor
