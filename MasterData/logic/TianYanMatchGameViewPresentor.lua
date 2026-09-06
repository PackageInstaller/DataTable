-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchGameViewPresentor.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchGameViewPresentor", package.seeall)

local TianYanMatchGameViewPresentor = class("TianYanMatchGameViewPresentor", ViewPresentor)

function TianYanMatchGameViewPresentor:ctor()
	TianYanMatchGameViewPresentor.super.ctor(self)
end

function TianYanMatchGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function TianYanMatchGameViewPresentor:dependWhatResources()
	return {
		"ui/views/tianyanmatch/tianyanmatchgameview.prefab"
	}
end

function TianYanMatchGameViewPresentor:buildViews()
	return {
		TianYanMatchGameView.New()
	}
end

return TianYanMatchGameViewPresentor
