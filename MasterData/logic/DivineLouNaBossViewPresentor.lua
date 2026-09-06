-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/DivineLouNaBossViewPresentor.lua

module("logic.extensions.shenjichallenge.view.DivineLouNaBossViewPresentor", package.seeall)

local DivineLouNaBossViewPresentor = class("DivineLouNaBossViewPresentor", ViewPresentor)

function DivineLouNaBossViewPresentor:ctor()
	DivineLouNaBossViewPresentor.super.ctor(self)
end

function DivineLouNaBossViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineLouNaBossViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/divinelounabossview.prefab"
	}
end

function DivineLouNaBossViewPresentor:buildViews()
	return {
		DivineLouNaBossView.New()
	}
end

return DivineLouNaBossViewPresentor
