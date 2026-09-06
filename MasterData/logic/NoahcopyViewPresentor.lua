-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/noah/NoahcopyViewPresentor.lua

module("logic.extensions.scenariocopy.view.noah.NoahcopyViewPresentor", package.seeall)

local NoahcopyViewPresentor = class("NoahcopyViewPresentor", ViewPresentor)

NoahcopyViewPresentor.BgEffectPath = "fx_ui_2021930/fx_ui_jqfb_nuoya/fx_ui_jqfb_nuoya_beijing.prefab"
NoahcopyViewPresentor.LevelEffectPath = "fx_ui_2021930/fx_ui_jqfb_nuoya/fx_ui_jqfb_nuoya_kuang.prefab"
NoahcopyViewPresentor.ZhuanChangEffectPath = "fx_ui_2021930/fx_ui_jqfb_nuoya/fx_ui_jqfb_nuoya_zhuanchang.prefab"

function NoahcopyViewPresentor:ctor()
	NoahcopyViewPresentor.super.ctor(self)
end

function NoahcopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function NoahcopyViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/noah/noahcopyview.prefab"
	}
end

function NoahcopyViewPresentor:buildViews()
	return {
		NoahCopyView.New()
	}
end

return NoahcopyViewPresentor
