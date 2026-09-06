-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/DivineLouNaSelectViewPresentor.lua

module("logic.extensions.shenjichallenge.view.DivineLouNaSelectViewPresentor", package.seeall)

local DivineLouNaSelectViewPresentor = class("DivineLouNaSelectViewPresentor", ViewPresentor)

function DivineLouNaSelectViewPresentor:ctor()
	DivineLouNaSelectViewPresentor.super.ctor(self)
end

function DivineLouNaSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineLouNaSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/divinelounaselectview.prefab"
	}
end

function DivineLouNaSelectViewPresentor:buildViews()
	return {
		DivineLouNaSelectView.New()
	}
end

return DivineLouNaSelectViewPresentor
