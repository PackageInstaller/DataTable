-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/NewGuessLanternAnswerViewPresentor.lua

module("logic.extensions.elvesrevealed.view.NewGuessLanternAnswerViewPresentor", package.seeall)

local NewGuessLanternAnswerViewPresentor = class("NewGuessLanternAnswerViewPresentor", ViewPresentor)

NewGuessLanternAnswerViewPresentor.Effect1 = "20230929/zhongqiucaidengmi/fx_ui_caidengmi_datiguang.prefab"

function NewGuessLanternAnswerViewPresentor:ctor()
	NewGuessLanternAnswerViewPresentor.super.ctor(self)
end

function NewGuessLanternAnswerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewGuessLanternAnswerViewPresentor:dependWhatResources()
	return {
		"ui/views/guesslantern/newguesslanternanswerview.prefab"
	}
end

function NewGuessLanternAnswerViewPresentor:buildViews()
	return {
		NewGuessLanternAnswerView.New()
	}
end

return NewGuessLanternAnswerViewPresentor
