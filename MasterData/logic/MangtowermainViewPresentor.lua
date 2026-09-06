-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangtowermainViewPresentor.lua

module("logic.extensions.mangtower.view.MangtowermainViewPresentor", package.seeall)

local MangtowermainViewPresentor = class("MangtowermainViewPresentor", ViewPresentor)

function MangtowermainViewPresentor:ctor()
	MangtowermainViewPresentor.super.ctor(self)
end

function MangtowermainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MangtowermainViewPresentor:dependWhatResources()
	return {
		"ui/views/mangtower/mangtowermainview.prefab"
	}
end

function MangtowermainViewPresentor:buildViews()
	return {
		MangTowerMainView.New()
	}
end

function ExpBuffEventViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath("fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_anniu.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_01_blue.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_01.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_02.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_03_red.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_03_blue.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_05_blue.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_05_red.prefab"),
		UIEffectManager.instance:getEffectPath("fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_zhuanchang.prefab")
	}
end

return MangtowermainViewPresentor
