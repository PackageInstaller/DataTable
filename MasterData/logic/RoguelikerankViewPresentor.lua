-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikerankViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikerankViewPresentor", package.seeall)

local RoguelikerankViewPresentor = class("RoguelikerankViewPresentor", ViewPresentor)

function RoguelikerankViewPresentor:ctor()
	RoguelikerankViewPresentor.super.ctor(self)
end

function RoguelikerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikerankViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikerankview.prefab"
	}
end

function RoguelikerankViewPresentor:buildViews()
	return {
		RoguelikerankView.New()
	}
end

function RoguelikerankViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return RoguelikerankViewPresentor
