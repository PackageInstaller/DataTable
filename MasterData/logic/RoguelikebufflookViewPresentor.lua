-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikebufflookViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikebufflookViewPresentor", package.seeall)

local RoguelikebufflookViewPresentor = class("RoguelikebufflookViewPresentor", ViewPresentor)

function RoguelikebufflookViewPresentor:ctor()
	RoguelikebufflookViewPresentor.super.ctor(self)
end

function RoguelikebufflookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikebufflookViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikebufflookview.prefab"
	}
end

function RoguelikebufflookViewPresentor:buildViews()
	return {
		RoguelikebufflookView.New()
	}
end

return RoguelikebufflookViewPresentor
