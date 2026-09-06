-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/flip/FlipGameMainCopyOfTourArenaViewPresentor.lua

module("logic.extensions.tourarena.view.copy.flip.FlipGameMainCopyOfTourArenaViewPresentor", package.seeall)

local FlipGameMainCopyOfTourArenaViewPresentor = class("FlipGameMainCopyOfTourArenaViewPresentor", ViewPresentor)

function FlipGameMainCopyOfTourArenaViewPresentor:ctor()
	FlipGameMainCopyOfTourArenaViewPresentor.super.ctor(self)
end

function FlipGameMainCopyOfTourArenaViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FlipGameMainCopyOfTourArenaViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteam/smallgame/flipgamemainview.prefab"
	}
end

function FlipGameMainCopyOfTourArenaViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_dianliangmengzhidui/fx_ui_xiaochu_mzd.prefab")
	}
end

function FlipGameMainCopyOfTourArenaViewPresentor:buildViews()
	return {
		FlipGameMainCopyOfTourArenaView.New()
	}
end

return FlipGameMainCopyOfTourArenaViewPresentor
