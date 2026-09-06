-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanGameViewPresentor.lua

module("logic.extensions.guesssnowman.view.GuessSnowmanGameViewPresentor", package.seeall)

local GuessSnowmanGameViewPresentor = class("GuessSnowmanGameViewPresentor", ViewPresentor)

function GuessSnowmanGameViewPresentor:ctor()
	GuessSnowmanGameViewPresentor.super.ctor(self)
end

function GuessSnowmanGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessSnowmanGameViewPresentor:dependWhatResources()
	return {
		"ui/views/guesssnowman/guesssnowmangameview.prefab"
	}
end

function GuessSnowmanGameViewPresentor:buildViews()
	return {
		GuessSnowmanGameView.New()
	}
end

return GuessSnowmanGameViewPresentor
