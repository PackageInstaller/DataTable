-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanRankViewPresentor.lua

module("logic.extensions.guesssnowman.view.GuessSnowmanRankViewPresentor", package.seeall)

local GuessSnowmanRankViewPresentor = class("GuessSnowmanRankViewPresentor", ViewPresentor)

function GuessSnowmanRankViewPresentor:ctor()
	GuessSnowmanRankViewPresentor.super.ctor(self)
end

function GuessSnowmanRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessSnowmanRankViewPresentor:dependWhatResources()
	return {
		"ui/views/guesssnowman/guesssnowmanrankview.prefab"
	}
end

function GuessSnowmanRankViewPresentor:buildViews()
	return {
		GuessSnowmanRankView.New()
	}
end

return GuessSnowmanRankViewPresentor
