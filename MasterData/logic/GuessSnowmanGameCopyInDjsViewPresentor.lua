-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/copyindjs/GuessSnowmanGameCopyInDjsViewPresentor.lua

module("logic.extensions.guesssnowman.view.copyindjs.GuessSnowmanGameCopyInDjsViewPresentor", package.seeall)

local GuessSnowmanGameCopyInDjsViewPresentor = class("GuessSnowmanGameCopyInDjsViewPresentor", ViewPresentor)

function GuessSnowmanGameCopyInDjsViewPresentor:ctor()
	GuessSnowmanGameCopyInDjsViewPresentor.super.ctor(self)
end

function GuessSnowmanGameCopyInDjsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessSnowmanGameCopyInDjsViewPresentor:dependWhatResources()
	return {
		"ui/views/guesssnowman/copyindjs/guesssnowmangamecopyindjsview.prefab"
	}
end

function GuessSnowmanGameCopyInDjsViewPresentor:buildViews()
	return {
		GuessSnowmanGameCopyInDjsView.New()
	}
end

return GuessSnowmanGameCopyInDjsViewPresentor
