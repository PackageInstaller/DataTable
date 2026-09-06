-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanMainViewPresentor.lua

module("logic.extensions.guesssnowman.view.GuessSnowmanMainViewPresentor", package.seeall)

local GuessSnowmanMainViewPresentor = class("GuessSnowmanMainViewPresentor", ViewPresentor)

function GuessSnowmanMainViewPresentor:ctor()
	GuessSnowmanMainViewPresentor.super.ctor(self)
end

function GuessSnowmanMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessSnowmanMainViewPresentor:dependWhatResources()
	return {
		"ui/views/guesssnowman/guesssnowmanmainview.prefab"
	}
end

function GuessSnowmanMainViewPresentor:buildViews()
	return {
		GuessSnowmanMainView.New()
	}
end

return GuessSnowmanMainViewPresentor
