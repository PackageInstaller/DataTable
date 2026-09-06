-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanSelectViewPresentor.lua

module("logic.extensions.guesssnowman.view.GuessSnowmanSelectViewPresentor", package.seeall)

local GuessSnowmanSelectViewPresentor = class("GuessSnowmanSelectViewPresentor", ViewPresentor)

function GuessSnowmanSelectViewPresentor:ctor()
	GuessSnowmanSelectViewPresentor.super.ctor(self)
end

function GuessSnowmanSelectViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GuessSnowmanSelectViewPresentor:dependWhatResources()
	return {
		"ui/views/guesssnowman/guesssnowmanselectview.prefab"
	}
end

function GuessSnowmanSelectViewPresentor:buildViews()
	return {
		GuessSnowmanSelectView.New()
	}
end

return GuessSnowmanSelectViewPresentor
