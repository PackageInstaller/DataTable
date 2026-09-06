-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/view/GuessBoxResultViewPresentor.lua

module("logic.extensions.guessbox.view.GuessBoxResultViewPresentor", package.seeall)

local GuessBoxResultViewPresentor = class("GuessBoxResultViewPresentor", ViewPresentor)

function GuessBoxResultViewPresentor:ctor()
	GuessBoxResultViewPresentor.super.ctor(self)
end

function GuessBoxResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessBoxResultViewPresentor:dependWhatResources()
	return {
		"ui/views/guessbox/guessboxresultview.prefab"
	}
end

function GuessBoxResultViewPresentor:buildViews()
	return {
		GuessBoxResultView.New()
	}
end

return GuessBoxResultViewPresentor
