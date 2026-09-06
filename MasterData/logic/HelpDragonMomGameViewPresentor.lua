-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/HelpDragonMomGameViewPresentor.lua

module("logic.extensions.helpdragonmom.view.HelpDragonMomGameViewPresentor", package.seeall)

local HelpDragonMomGameViewPresentor = class("HelpDragonMomGameViewPresentor", ViewPresentor)

HelpDragonMomGameViewPresentor.StonePath = "20220602/jingshidonghua/fx_ui_hyll_jsdh_js.prefab"
HelpDragonMomGameViewPresentor.ScorePath1 = "20220602/jingshidonghua/fx_ui_hyll_jsdh_ziti_nl1.prefab"
HelpDragonMomGameViewPresentor.ScorePath5 = "20220602/jingshidonghua/fx_ui_hyll_jsdh_ziti_bj5.prefab"
HelpDragonMomGameViewPresentor.ScorePath10 = "20220602/jingshidonghua/fx_ui_hyll_jsdh_ziti_cbj.prefab"
HelpDragonMomGameViewPresentor.BombPath = "20220602/jingshidonghua/fx_ui_hyll_jsdh_bd.prefab"

function HelpDragonMomGameViewPresentor:ctor()
	HelpDragonMomGameViewPresentor.super.ctor(self)
end

function HelpDragonMomGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function HelpDragonMomGameViewPresentor:dependWhatResources()
	return {
		"ui/views/helpdragonmom/helpdragonmomgameview.prefab"
	}
end

function HelpDragonMomGameViewPresentor:buildViews()
	return {
		HelpDragonMomGameView.New()
	}
end

function HelpDragonMomGameViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(HelpDragonMomGameViewPresentor.StonePath),
		UIEffectManager.instance:getEffectPath(HelpDragonMomGameViewPresentor.ScorePath1),
		UIEffectManager.instance:getEffectPath(HelpDragonMomGameViewPresentor.ScorePath5),
		UIEffectManager.instance:getEffectPath(HelpDragonMomGameViewPresentor.ScorePath10),
		UIEffectManager.instance:getEffectPath(HelpDragonMomGameViewPresentor.BombPath)
	}
end

return HelpDragonMomGameViewPresentor
