-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaBuffViewPresentor.lua

module("logic.extensions.funarena.view.FunArenaBuffViewPresentor", package.seeall)

local FunArenaBuffViewPresentor = class("FunArenaBuffViewPresentor", ViewPresentor)

function FunArenaBuffViewPresentor:ctor()
	FunArenaBuffViewPresentor.super.ctor(self)
end

function FunArenaBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunArenaBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/funarena/funarenabuffview.prefab"
	}
end

function FunArenaBuffViewPresentor:buildViews()
	return {
		FunArenaBuffView.New()
	}
end

return FunArenaBuffViewPresentor
