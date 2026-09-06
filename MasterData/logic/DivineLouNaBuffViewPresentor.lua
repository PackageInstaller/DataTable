-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/DivineLouNaBuffViewPresentor.lua

module("logic.extensions.shenjichallenge.view.DivineLouNaBuffViewPresentor", package.seeall)

local DivineLouNaBuffViewPresentor = class("DivineLouNaBuffViewPresentor", ViewPresentor)

function DivineLouNaBuffViewPresentor:ctor()
	DivineLouNaBuffViewPresentor.super.ctor(self)
end

function DivineLouNaBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineLouNaBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/shenjichallenge/divinelounabuffview.prefab"
	}
end

function DivineLouNaBuffViewPresentor:buildViews()
	return {
		DivineLouNaBuffView.New()
	}
end

return DivineLouNaBuffViewPresentor
