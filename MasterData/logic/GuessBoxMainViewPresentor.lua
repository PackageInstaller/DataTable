-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/view/GuessBoxMainViewPresentor.lua

module("logic.extensions.guessbox.view.GuessBoxMainViewPresentor", package.seeall)

local GuessBoxMainViewPresentor = class("GuessBoxMainViewPresentor", ViewPresentor)

function GuessBoxMainViewPresentor:ctor()
	GuessBoxMainViewPresentor.super.ctor(self)
end

function GuessBoxMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessBoxMainViewPresentor:dependWhatResources()
	return {
		"ui/views/guessbox/guessboxmainview.prefab"
	}
end

function GuessBoxMainViewPresentor:buildViews()
	return {
		GuessBoxMainView.New()
	}
end

return GuessBoxMainViewPresentor
