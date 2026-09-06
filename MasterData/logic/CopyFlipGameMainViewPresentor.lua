-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/game/flip/CopyFlipGameMainViewPresentor.lua

module("logic.extensions.suppressgame.view.game.flip.CopyFlipGameMainViewPresentor", package.seeall)

local CopyFlipGameMainViewPresentor = class("CopyFlipGameMainViewPresentor", ViewPresentor)

function CopyFlipGameMainViewPresentor:ctor()
	CopyFlipGameMainViewPresentor.super.ctor(self)
end

function CopyFlipGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CopyFlipGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteam/smallgame/flipgamemainview.prefab"
	}
end

function CopyFlipGameMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_dianliangmengzhidui/fx_ui_xiaochu_mzd.prefab")
	}
end

function CopyFlipGameMainViewPresentor:buildViews()
	return {
		CopyFlipGameMainView.New()
	}
end

return CopyFlipGameMainViewPresentor
