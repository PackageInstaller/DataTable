-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingLoopViewPresentor.lua

module("logic.extensions.chopking.view.ChopKingLoopViewPresentor", package.seeall)

local ChopKingLoopViewPresentor = class("ChopKingLoopViewPresentor", ViewPresentor)

function ChopKingLoopViewPresentor:ctor()
	ChopKingLoopViewPresentor.super.ctor(self)
end

function ChopKingLoopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChopKingLoopViewPresentor:dependWhatResources()
	return {
		"ui/views/chopking/chopkingloopview.prefab"
	}
end

function ChopKingLoopViewPresentor:buildViews()
	return {
		ChopKingLoopView.New()
	}
end

return ChopKingLoopViewPresentor
