-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funcamp/view/funcampmain/FunCampMainViewPresentor.lua

module("logic.extensions.funcamp.view.funcampmain.FunCampMainViewPresentor", package.seeall)

local FunCampMainViewPresentor = class("FunCampMainViewPresentor", ViewPresentor)

FunCampMainViewPresentor.Effect1 = "20220902/quweizhenying/fx_ui_quweizhenying_jm1.prefab"
FunCampMainViewPresentor.Effect2 = "20220902/quweizhenying/fx_ui_quweizhenying_jm2.prefab"

function FunCampMainViewPresentor:ctor()
	FunCampMainViewPresentor.super.ctor(self)
end

function FunCampMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function FunCampMainViewPresentor:dependWhatResources()
	return {
		"ui/views/funcamp/funcampmainview.prefab"
	}
end

function FunCampMainViewPresentor:buildViews()
	return {
		FunCampMainView.New()
	}
end

function FunCampMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(FunCampMainViewPresentor.Effect1)
	}
end

return FunCampMainViewPresentor
