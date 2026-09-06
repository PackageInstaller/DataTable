-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaFailSimpleViewPresentor.lua

module("logic.extensions.funarena.view.FunArenaFailSimpleViewPresentor", package.seeall)

local FunArenaFailSimpleViewPresentor = class("FunArenaFailSimpleViewPresentor", ViewPresentor)

function FunArenaFailSimpleViewPresentor:ctor()
	FunArenaFailSimpleViewPresentor.super.ctor(self)
end

function FunArenaFailSimpleViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunArenaFailSimpleViewPresentor:dependWhatResources()
	return {
		"ui/views/funarena/funarenafailsimple.prefab"
	}
end

function FunArenaFailSimpleViewPresentor:buildViews()
	return {
		FunArenaFailSimpleView.New()
	}
end

return FunArenaFailSimpleViewPresentor
