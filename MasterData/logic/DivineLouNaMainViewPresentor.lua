-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/DivineLouNaMainViewPresentor.lua

module("logic.extensions.shenjichallenge.view.DivineLouNaMainViewPresentor", package.seeall)

local DivineLouNaMainViewPresentor = class("DivineLouNaMainViewPresentor", ViewPresentor)

function DivineLouNaMainViewPresentor:ctor()
	DivineLouNaMainViewPresentor.super.ctor(self)
end

function DivineLouNaMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineLouNaMainViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/divinelounamainview.prefab"
	}
end

function DivineLouNaMainViewPresentor:buildViews()
	return {
		DivineLouNaMainView.New()
	}
end

return DivineLouNaMainViewPresentor
