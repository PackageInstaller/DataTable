-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/LongYanSQLevelViewPresentor.lua

module("logic.extensions.godlongyan.view.LongYanSQLevelViewPresentor", package.seeall)

local LongYanSQLevelViewPresentor = class("LongYanSQLevelViewPresentor", ViewPresentor)

LongYanSQLevelViewPresentor.DefaultBgPath = "ui/bigbg/godlongyan/bg_shenqilongyan_03.png"
LongYanSQLevelViewPresentor.DefaultBgPath2 = "ui/bigbg/godlongyan/bg_shenqilongyan_03_1.png"
LongYanSQLevelViewPresentor.DefaultBgPath3 = "ui/bigbg/godlongyan/bg_shenqilongyan_03_2.png"
LongYanSQLevelViewPresentor.Effect1 = "20220429/shenweitiaozhan/fx_ui_shenweitiaozhan_huang.prefab"
LongYanSQLevelViewPresentor.Effect2 = "20220429/shenweitiaozhan/fx_ui_shenweitiaozhan_hong.prefab"
LongYanSQLevelViewPresentor.Effect3 = "20220429/shenweitiaozhan/fx_ui_shenweitiaozhan_zi.prefab"

function LongYanSQLevelViewPresentor:ctor()
	LongYanSQLevelViewPresentor.super.ctor(self)
end

function LongYanSQLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LongYanSQLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/godlongyan/longyansqlevelview.prefab"
	}
end

function LongYanSQLevelViewPresentor:buildViews()
	return {
		LongYanSQLevelView.New()
	}
end

function LongYanSQLevelViewPresentor:getTempResources()
	return {
		LongYanSQLevelViewPresentor.DefaultBgPath,
		LongYanSQLevelViewPresentor.DefaultBgPath2,
		LongYanSQLevelViewPresentor.DefaultBgPath3,
		UIEffectManager.instance:getEffectPath(LongYanSQLevelViewPresentor.Effect1),
		UIEffectManager.instance:getEffectPath(LongYanSQLevelViewPresentor.Effect2),
		UIEffectManager.instance:getEffectPath(LongYanSQLevelViewPresentor.Effect3)
	}
end

return LongYanSQLevelViewPresentor
