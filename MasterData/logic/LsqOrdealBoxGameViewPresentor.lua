-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/LsqOrdealBoxGameViewPresentor.lua

module("logic.extensions.luoshiqiordeal.view.LsqOrdealBoxGameViewPresentor", package.seeall)

local LsqOrdealBoxGameViewPresentor = class("LsqOrdealBoxGameViewPresentor", ViewPresentor)

LsqOrdealBoxGameViewPresentor.Effect1 = "20221125/luoshiqi/fx_ui_lsqkaoyan_lihehuode.prefab"

function LsqOrdealBoxGameViewPresentor:ctor()
	LsqOrdealBoxGameViewPresentor.super.ctor(self)
end

function LsqOrdealBoxGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LsqOrdealBoxGameViewPresentor:dependWhatResources()
	return {
		"ui/views/luoshiqiordeal/lsqordealboxgameview.prefab"
	}
end

function LsqOrdealBoxGameViewPresentor:buildViews()
	return {
		LsqOrdealBoxGameView.New()
	}
end

function LsqOrdealBoxGameViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(LsqOrdealBoxGameViewPresentor.Effect1)
	}
end

return LsqOrdealBoxGameViewPresentor
