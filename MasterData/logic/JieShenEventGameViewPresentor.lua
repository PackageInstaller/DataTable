-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventGameViewPresentor.lua

module("logic.extensions.jieshenevent.view.JieShenEventGameViewPresentor", package.seeall)

local JieShenEventGameViewPresentor = class("JieShenEventGameViewPresentor", ViewPresentor)

function JieShenEventGameViewPresentor:ctor()
	JieShenEventGameViewPresentor.super.ctor(self)
end

function JieShenEventGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieShenEventGameViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenevent/jiesheneventgameview.prefab"
	}
end

function JieShenEventGameViewPresentor:buildViews()
	return {
		JieShenEventGameView.New()
	}
end

return JieShenEventGameViewPresentor
