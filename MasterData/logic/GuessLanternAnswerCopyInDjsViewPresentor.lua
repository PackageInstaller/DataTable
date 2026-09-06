-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/copyindjs/GuessLanternAnswerCopyInDjsViewPresentor.lua

module("logic.extensions.guesslantern.view.copyindjs.GuessLanternAnswerCopyInDjsViewPresentor", package.seeall)

local GuessLanternAnswerCopyInDjsViewPresentor = class("GuessLanternAnswerCopyInDjsViewPresentor", ViewPresentor)

GuessLanternAnswerCopyInDjsViewPresentor.Effect1 = "20230929/zhongqiucaidengmi/fx_ui_caidengmi_datiguang.prefab"

function GuessLanternAnswerCopyInDjsViewPresentor:ctor()
	GuessLanternAnswerCopyInDjsViewPresentor.super.ctor(self)
end

function GuessLanternAnswerCopyInDjsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessLanternAnswerCopyInDjsViewPresentor:dependWhatResources()
	return {
		"ui/views/guesslantern/copyindjs/guesslanternanswercopyindjsview.prefab"
	}
end

function GuessLanternAnswerCopyInDjsViewPresentor:buildViews()
	return {
		GuessLanternAnswerCopyInDjsView.New()
	}
end

return GuessLanternAnswerCopyInDjsViewPresentor
