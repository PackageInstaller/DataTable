-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanResultViewPresentor.lua

module("logic.extensions.guessbox.view.GuessSnowmanResultViewPresentor", package.seeall)

local GuessSnowmanResultViewPresentor = class("GuessSnowmanResultViewPresentor", ViewPresentor)

function GuessSnowmanResultViewPresentor:ctor()
	GuessSnowmanResultViewPresentor.super.ctor(self)
end

function GuessSnowmanResultViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function GuessSnowmanResultViewPresentor:dependWhatResources()
	return {
		"ui/views/guesssnowman/guesssnowmanresultview.prefab"
	}
end

function GuessSnowmanResultViewPresentor:buildViews()
	return {
		GuessSnowmanResultView.New()
	}
end

return GuessSnowmanResultViewPresentor
