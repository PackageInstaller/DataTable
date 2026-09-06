-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarVoteViewPresentor.lua

module("logic.extensions.ultimatewar.view.UltimateWarVoteViewPresentor", package.seeall)

local UltimateWarVoteViewPresentor = class("UltimateWarVoteViewPresentor", ViewPresentor)

function UltimateWarVoteViewPresentor:ctor()
	UltimateWarVoteViewPresentor.super.ctor(self)
end

function UltimateWarVoteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function UltimateWarVoteViewPresentor:dependWhatResources()
	return {
		"ui/views/ultimatewar/ultimatewarvoteview.prefab"
	}
end

function UltimateWarVoteViewPresentor:buildViews()
	return {
		UltimateWarVoteView.New()
	}
end

return UltimateWarVoteViewPresentor
