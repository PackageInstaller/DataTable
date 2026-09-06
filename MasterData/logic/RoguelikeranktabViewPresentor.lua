-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikeranktabViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikeranktabViewPresentor", package.seeall)

local RoguelikeranktabViewPresentor = class("RoguelikeranktabViewPresentor", ViewPresentor)

function RoguelikeranktabViewPresentor:ctor()
	RoguelikeranktabViewPresentor.super.ctor(self)
end

function RoguelikeranktabViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikeranktabViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikeranktabview.prefab"
	}
end

function RoguelikeranktabViewPresentor:buildViews()
	return {
		RoguelikeranktabView.New()
	}
end

return RoguelikeranktabViewPresentor
