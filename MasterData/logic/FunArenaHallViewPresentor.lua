-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaHallViewPresentor.lua

module("logic.extensions.funarena.view.FunArenaHallViewPresentor", package.seeall)

local FunArenaHallViewPresentor = class("FunArenaHallViewPresentor", ViewPresentor)

function FunArenaHallViewPresentor:ctor()
	FunArenaHallViewPresentor.super.ctor(self)
end

function FunArenaHallViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunArenaHallViewPresentor:dependWhatResources()
	return {
		"ui/views/funarena/funarenahallview.prefab"
	}
end

function FunArenaHallViewPresentor:buildViews()
	return {
		FunArenaHallView.New()
	}
end

return FunArenaHallViewPresentor
