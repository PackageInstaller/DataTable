-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesslantern/view/GuessLanternMainViewPresentor.lua

module("logic.extensions.guesslantern.view.GuessLanternMainViewPresentor", package.seeall)

local GuessLanternMainViewPresentor = class("GuessLanternMainViewPresentor", ViewPresentor)

GuessLanternMainViewPresentor.Effect1 = "20230929/zhongqiucaidengmi/fx_ui_caidengmi_fw.prefab"
GuessLanternMainViewPresentor.Effect2 = "20230929/zhongqiucaidengmi/fx_ui_caidengmi_dianliang.prefab"

function GuessLanternMainViewPresentor:ctor()
	GuessLanternMainViewPresentor.super.ctor(self)
end

function GuessLanternMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuessLanternMainViewPresentor:dependWhatResources()
	return {
		"ui/views/guesslantern/guesslanternmainview.prefab"
	}
end

function GuessLanternMainViewPresentor:buildViews()
	return {
		GuessLanternMainView.New()
	}
end

return GuessLanternMainViewPresentor
