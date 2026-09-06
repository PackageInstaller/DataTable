-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/eatcake/EatCakeGameMainViewPresentor.lua

module("logic.extensions.anniversarycake.view.eatcake.EatCakeGameMainViewPresentor", package.seeall)

local EatCakeGameMainViewPresentor = class("EatCakeGameMainViewPresentor", ViewPresentor)

EatCakeGameMainViewPresentor.EffectPath1 = "20220401/zhouniandangaohuodong/fx_ui_kaishidati_cjl.prefab"
EatCakeGameMainViewPresentor.EffectPath2 = "20220401/chidangaotexiao/fx_ui_chidangaotexiao_guangxiao.prefab"

function EatCakeGameMainViewPresentor:ctor()
	EatCakeGameMainViewPresentor.super.ctor(self)
end

function EatCakeGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function EatCakeGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarycake/eatcakegamemainview.prefab"
	}
end

function EatCakeGameMainViewPresentor:buildViews()
	return {
		EatCakeGameMainView.New()
	}
end

function EatCakeGameMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(EatCakeGameMainViewPresentor.EffectPath1),
		UIEffectManager.instance:getEffectPath(EatCakeGameMainViewPresentor.EffectPath2)
	}
end

return EatCakeGameMainViewPresentor
