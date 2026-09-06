-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/LsqOrdealMainViewPresentor.lua

module("logic.extensions.luoshiqiordeal.view.LsqOrdealMainViewPresentor", package.seeall)

local LsqOrdealMainViewPresentor = class("LsqOrdealMainViewPresentor", ViewPresentor)

LsqOrdealMainViewPresentor.Effect1 = "20221125/luoshiqi/fx_ui_lsqky.prefab"
LsqOrdealMainViewPresentor.Effect2 = "20221125/luoshiqi/fx_ui_lsqky_lihefenwei.prefab"

function LsqOrdealMainViewPresentor:ctor()
	LsqOrdealMainViewPresentor.super.ctor(self)
end

function LsqOrdealMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LsqOrdealMainViewPresentor:dependWhatResources()
	return {
		"ui/views/luoshiqiordeal/lsqordealmainview.prefab"
	}
end

function LsqOrdealMainViewPresentor:buildViews()
	return {
		LsqOrdealMainView.New()
	}
end

function LsqOrdealMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(LsqOrdealMainViewPresentor.Effect1),
		UIEffectManager.instance:getEffectPath(LsqOrdealMainViewPresentor.Effect2)
	}
end

return LsqOrdealMainViewPresentor
