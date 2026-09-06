-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RogueliketaskViewPresentor.lua

module("logic.extensions.roguelike.view.RogueliketaskViewPresentor", package.seeall)

local RogueliketaskViewPresentor = class("RogueliketaskViewPresentor", ViewPresentor)

function RogueliketaskViewPresentor:ctor()
	RogueliketaskViewPresentor.super.ctor(self)
end

function RogueliketaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RogueliketaskViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/rogueliketaskview.prefab"
	}
end

function RogueliketaskViewPresentor:buildViews()
	return {
		RogueliketaskView.New()
	}
end

return RogueliketaskViewPresentor
