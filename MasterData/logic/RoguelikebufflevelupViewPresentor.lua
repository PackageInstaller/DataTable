-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikebufflevelupViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikebufflevelupViewPresentor", package.seeall)

local RoguelikebufflevelupViewPresentor = class("RoguelikebufflevelupViewPresentor", ViewPresentor)

RoguelikebufflevelupViewPresentor.LvUpEffectPath = "20240726/rougewanfa/fx_ui_zhufu_fw.prefab"

function RoguelikebufflevelupViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikebufflevelupViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikebufflevelupview.prefab"
	}
end

function RoguelikebufflevelupViewPresentor:buildViews()
	return {
		RoguelikebufflevelupView.New()
	}
end

function RoguelikebufflevelupViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(RoguelikebufflevelupViewPresentor.LvUpEffectPath)
	}
end

return RoguelikebufflevelupViewPresentor
