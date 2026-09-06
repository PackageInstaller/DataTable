-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampDonateViewPresentor.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampDonateViewPresentor", package.seeall)

local FunCampDonateViewPresentor = class("FunCampDonateViewPresentor", ViewPresentor)

FunCampDonateViewPresentor.Effect1 = "20220902/quweizhenying/fx_ui_quweizhenying_sjg_blue.prefab"
FunCampDonateViewPresentor.Effect2 = "20220902/quweizhenying/fx_ui_quweizhenying_sjg_green.prefab"
FunCampDonateViewPresentor.Effect3 = "20220902/quweizhenying/fx_ui_quweizhenying_sjg_yellow.prefab"
FunCampDonateViewPresentor.DonateEffect1 = "20220902/quweizhenying/fx_ui_quweizhenying_sjs_blue.prefab"
FunCampDonateViewPresentor.DonateEffect2 = "20220902/quweizhenying/fx_ui_quweizhenying_sjs_green.prefab"
FunCampDonateViewPresentor.DonateEffect3 = "20220902/quweizhenying/fx_ui_quweizhenying_sjs_yellow.prefab"

function FunCampDonateViewPresentor:ctor()
	FunCampDonateViewPresentor.super.ctor(self)
end

function FunCampDonateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunCampDonateViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcampdonateview.prefab"
	}
end

function FunCampDonateViewPresentor:buildViews()
	return {
		FunCampDonateView.New()
	}
end

function FunCampDonateViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(FunCampDonateViewPresentor.Effect1),
		UIEffectManager.instance:getEffectPath(FunCampDonateViewPresentor.Effect2),
		UIEffectManager.instance:getEffectPath(FunCampDonateViewPresentor.Effect3)
	}
end

return FunCampDonateViewPresentor
