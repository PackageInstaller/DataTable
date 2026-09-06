-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/onepeople/OnePeopleCopyViewPresentor.lua

module("logic.extensions.scenariocopy.view.onepeople.OnePeopleCopyViewPresentor", package.seeall)

local OnePeopleCopyViewPresentor = class("OnePeopleCopyViewPresentor", ViewPresentor)

OnePeopleCopyViewPresentor.BgEffectPath = "fx_ui_yrzxjuqingfuben/fx_ui_qimenzhenhai_shandian.prefab"
OnePeopleCopyViewPresentor.SphereEffectPath = "fx_ui_yrzxjuqingfuben/fx_ui_qimenzhenhai_jqtz.prefab"
OnePeopleCopyViewPresentor.ChapterEffectPath = "fx_ui_yrzxjuqingfuben/fx_ui_qimenzhenhai_glow.prefab"
OnePeopleCopyViewPresentor.LevelEffectPath = "fx_ui_yrzxjuqingfuben/fx_ui_qimenzhenhai_glow_s.prefab"
OnePeopleCopyViewPresentor.IconPaths = {
	"ui/bigbg/onepeoplecopy/board_zhsdl_bg05.png",
	"ui/bigbg/onepeoplecopy/board_zhsdl_bg06.png",
	"ui/bigbg/onepeoplecopy/board_zhsdl_bg07.png",
	"ui/bigbg/onepeoplecopy/board_zhsdl_bg08.png"
}

function OnePeopleCopyViewPresentor:ctor()
	OnePeopleCopyViewPresentor.super.ctor(self)
end

function OnePeopleCopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OnePeopleCopyViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/onepeople/onepeoplecopyview.prefab"
	}
end

function OnePeopleCopyViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(OnePeopleCopyViewPresentor.BgEffectPath),
		UIEffectManager.instance:getEffectPath(OnePeopleCopyViewPresentor.SphereEffectPath),
		UIEffectManager.instance:getEffectPath(OnePeopleCopyViewPresentor.ChapterEffectPath),
		UIEffectManager.instance:getEffectPath(OnePeopleCopyViewPresentor.LevelEffectPath)
	}
end

function OnePeopleCopyViewPresentor:buildViews()
	return {
		OnePeopleCopyView.New()
	}
end

return OnePeopleCopyViewPresentor
