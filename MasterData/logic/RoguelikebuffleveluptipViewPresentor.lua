-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikebuffleveluptipViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikebuffleveluptipViewPresentor", package.seeall)

local RoguelikebuffleveluptipViewPresentor = class("RoguelikebuffleveluptipViewPresentor", ViewPresentor)

function RoguelikebuffleveluptipViewPresentor:ctor()
	RoguelikebuffleveluptipViewPresentor.super.ctor(self)
end

function RoguelikebuffleveluptipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikebuffleveluptipViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikebuffleveluptipview.prefab"
	}
end

function RoguelikebuffleveluptipViewPresentor:buildViews()
	return {
		RoguelikebuffleveluptipView.New()
	}
end

return RoguelikebuffleveluptipViewPresentor
