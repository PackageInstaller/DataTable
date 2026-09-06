-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/GuessLanternAnswerViewPresentor.lua

module("logic.extensions.guesslantern.view.GuessLanternAnswerViewPresentor", package.seeall)

local GuessLanternAnswerViewPresentor = class("GuessLanternAnswerViewPresentor", ViewPresentor)

GuessLanternAnswerViewPresentor.Effect1 = "20230929/zhongqiucaidengmi/fx_ui_caidengmi_datiguang.prefab"

function GuessLanternAnswerViewPresentor:ctor()
	GuessLanternAnswerViewPresentor.super.ctor(self)
end

function GuessLanternAnswerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessLanternAnswerViewPresentor:dependWhatResources()
	return {
		"ui/views/guesslantern/guesslanternanswerview.prefab"
	}
end

function GuessLanternAnswerViewPresentor:buildViews()
	return {
		GuessLanternAnswerView.New()
	}
end

return GuessLanternAnswerViewPresentor
