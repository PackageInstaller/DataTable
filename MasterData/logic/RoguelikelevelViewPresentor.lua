-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikelevelViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikelevelViewPresentor", package.seeall)

local RoguelikelevelViewPresentor = class("RoguelikelevelViewPresentor", ViewPresentor)

function RoguelikelevelViewPresentor:ctor()
	RoguelikelevelViewPresentor.super.ctor(self)
end

function RoguelikelevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikelevelViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikelevelview.prefab"
	}
end

function RoguelikelevelViewPresentor:buildViews()
	return {
		RoguelikelevelView.New()
	}
end

return RoguelikelevelViewPresentor
