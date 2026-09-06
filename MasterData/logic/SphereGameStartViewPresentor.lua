-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/spheregame/SphereGameStartViewPresentor.lua

module("logic.extensions.anniversarycake.view.spheregame.SphereGameStartViewPresentor", package.seeall)

local SphereGameStartViewPresentor = class("SphereGameStartViewPresentor", ViewPresentor)

SphereGameStartViewPresentor.EffectPath1 = "20220401/zhouniandangaomianban/fx_ui_zhouniandangao1_jiemian.prefab"
SphereGameStartViewPresentor.EffectPath2 = "20220401/zhouniandangaomianban/fx_ui_zhouniandangao2_jiemian.prefab"
SphereGameStartViewPresentor.EffectPath3 = "20220401/caijingling/fx_ui_kelingqu_cjl.prefab"

function SphereGameStartViewPresentor:ctor()
	SphereGameStartViewPresentor.super.ctor(self)
end

function SphereGameStartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SphereGameStartViewPresentor:dependWhatResources()
	return {
		"ui/views/anniversarycake/spheregamestartview.prefab"
	}
end

function SphereGameStartViewPresentor:buildViews()
	return {
		SphereGameStartView.New()
	}
end

function SphereGameStartViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(SphereGameStartViewPresentor.EffectPath1),
		UIEffectManager.instance:getEffectPath(SphereGameStartViewPresentor.EffectPath2),
		UIEffectManager.instance:getEffectPath(SphereGameStartViewPresentor.EffectPath3)
	}
end

return SphereGameStartViewPresentor
