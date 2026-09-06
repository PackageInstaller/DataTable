-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaViewPresentor.lua

module("logic.extensions.funarena.view.FunArenaViewPresentor", package.seeall)

local FunArenaViewPresentor = class("FunArenaViewPresentor", ViewPresentor)

function FunArenaViewPresentor:ctor()
	FunArenaViewPresentor.super.ctor(self)
end

function FunArenaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunArenaViewPresentor:dependWhatResources()
	return {
		"ui/views/funarena/funarenaview.prefab"
	}
end

function FunArenaViewPresentor:buildViews()
	return {
		FunArenaView.New()
	}
end

return FunArenaViewPresentor
