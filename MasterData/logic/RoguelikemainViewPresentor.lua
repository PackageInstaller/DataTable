-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikemainViewPresentor.lua

module("logic.extensions.roguelike.view.RoguelikemainViewPresentor", package.seeall)

local RoguelikemainViewPresentor = class("RoguelikemainViewPresentor", ViewPresentor)

RoguelikemainViewPresentor.BgEffectPath = "20240726/rougewanfa/fx_ui_rouge_fw.prefab"

function RoguelikemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RoguelikemainViewPresentor:dependWhatResources()
	return {
		"ui/views/roguelike/roguelikemainview.prefab"
	}
end

function RoguelikemainViewPresentor:buildViews()
	return {
		RoguelikemainView.New()
	}
end

function RoguelikemainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(RoguelikemainViewPresentor.BgEffectPath)
	}
end

return RoguelikemainViewPresentor
