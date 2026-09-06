-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampgame/FunCampGameMainViewPresentor.lua

module("logic.extensions.funcamp.view.funcampgame.FunCampGameMainViewPresentor", package.seeall)

local FunCampGameMainViewPresentor = class("FunCampGameMainViewPresentor", ViewPresentor)

function FunCampGameMainViewPresentor:ctor()
	FunCampGameMainViewPresentor.super.ctor(self)
end

function FunCampGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunCampGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/dreamteam/smallgame/flipgamemainview.prefab"
	}
end

function FunCampGameMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_dianliangmengzhidui/fx_ui_xiaochu_mzd.prefab")
	}
end

function FunCampGameMainViewPresentor:buildViews()
	return {
		FunCampGameMainView.New()
	}
end

return FunCampGameMainViewPresentor
