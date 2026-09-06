-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingCircleViewPresentor.lua

module("logic.extensions.chopking.view.ChopKingCircleViewPresentor", package.seeall)

local ChopKingCircleViewPresentor = class("ChopKingCircleViewPresentor", ViewPresentor)

function ChopKingCircleViewPresentor:ctor()
	ChopKingCircleViewPresentor.super.ctor(self)
end

function ChopKingCircleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChopKingCircleViewPresentor:dependWhatResources()
	return {
		"ui/views/chopking/chopkingcircleview.prefab"
	}
end

function ChopKingCircleViewPresentor:buildViews()
	return {
		ChopKingCircleView.New()
	}
end

return ChopKingCircleViewPresentor
