-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/FunArenaSuccessViewPresentor.lua

module("logic.extensions.funarena.view.FunArenaSuccessViewPresentor", package.seeall)

local FunArenaSuccessViewPresentor = class("FunArenaSuccessViewPresentor", ViewPresentor)

function FunArenaSuccessViewPresentor:ctor()
	FunArenaSuccessViewPresentor.super.ctor(self)
end

function FunArenaSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunArenaSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/funarena/funarenasuccessview.prefab"
	}
end

function FunArenaSuccessViewPresentor:buildViews()
	return {
		FunArenaSuccessView.New()
	}
end

return FunArenaSuccessViewPresentor
