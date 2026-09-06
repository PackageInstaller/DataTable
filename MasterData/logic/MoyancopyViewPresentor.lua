-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/moyan/MoyancopyViewPresentor.lua

module("logic.extensions.scenariocopy.view.moyan.MoyancopyViewPresentor", package.seeall)

local MoyancopyViewPresentor = class("MoyancopyViewPresentor", ViewPresentor)

MoyancopyViewPresentor.BgEffectPath = "fx_ui_zhongqiu/juqingfuben/fx_ui_mianban_fuben.prefab"
MoyancopyViewPresentor.BgPath = {
	"ui/bigbg/yyfb/board_bg_01.png",
	"ui/bigbg/yyfb/board_bg_02.png",
	"ui/bigbg/yyfb/board_bg_03.png"
}
MoyancopyViewPresentor.ChapterEffectPath = "fx_ui_zhongqiu/juqingfuben/fx_ui_kuang_fuben.prefab"
MoyancopyViewPresentor.LevelEffectPath = "fx_ui_zhongqiu/juqingfuben/fx_ui_anniu1_fuben.prefab"

function MoyancopyViewPresentor:ctor()
	MoyancopyViewPresentor.super.ctor(self)
end

function MoyancopyViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function MoyancopyViewPresentor:dependWhatResources()
	return {
		"ui/views/scenariocopy/moyan/moyancopyview.prefab"
	}
end

function MoyancopyViewPresentor:getTempResources()
	local res = {}

	table.insertto(res, MoyancopyViewPresentor.BgPath)
	table.insert(res, UIEffectManager.instance:getEffectPath(MoyancopyViewPresentor.BgEffectPath))
	table.insert(res, UIEffectManager.instance:getEffectPath(MoyancopyViewPresentor.ChapterEffectPath))
	table.insert(res, UIEffectManager.instance:getEffectPath(MoyancopyViewPresentor.LevelEffectPath))

	return res
end

function MoyancopyViewPresentor:buildViews()
	return {
		MoYanCopyView.New()
	}
end

return MoyancopyViewPresentor
