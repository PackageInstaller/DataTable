-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/NewGuessLanternMainViewPresentor.lua

module("logic.extensions.elvesrevealed.view.NewGuessLanternMainViewPresentor", package.seeall)

local NewGuessLanternMainViewPresentor = class("NewGuessLanternMainViewPresentor", ViewPresentor)

NewGuessLanternMainViewPresentor.Effect1 = "20230929/zhongqiucaidengmi/fx_ui_caidengmi_fw.prefab"
NewGuessLanternMainViewPresentor.Effect2 = "20230929/zhongqiucaidengmi/fx_ui_caidengmi_dianliang.prefab"

function NewGuessLanternMainViewPresentor:ctor()
	NewGuessLanternMainViewPresentor.super.ctor(self)
end

function NewGuessLanternMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NewGuessLanternMainViewPresentor:dependWhatResources()
	return {
		"ui/views/guesslantern/newguesslanternmainview.prefab"
	}
end

function NewGuessLanternMainViewPresentor:buildViews()
	return {
		NewGuessLanternMainView.New()
	}
end

return NewGuessLanternMainViewPresentor
