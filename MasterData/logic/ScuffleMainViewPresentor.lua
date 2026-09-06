-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleMainViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleMainViewPresentor", package.seeall)

local ScuffleMainViewPresentor = class("ScuffleMainViewPresentor", ViewPresentor)

ScuffleMainViewPresentor.PlayerBgPath = "fx_ui_jinglingdaluandou/fx_ui_jiemianrenwuxiaoguo.prefab"
ScuffleMainViewPresentor.MainViewBgPath = "fx_ui_jinglingdaluandou/fx_ui_jiemianbeijingxiaoguo.prefab"
ScuffleMainViewPresentor.ScoreUpPath = "fx_ui_jinglingdaluandou/fx_ui_jifenzengjia.prefab"

function ScuffleMainViewPresentor:ctor()
	ScuffleMainViewPresentor.super.ctor(self)
end

function ScuffleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleMainViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflemainview.prefab"
	}
end

function ScuffleMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(ScuffleMainViewPresentor.PlayerBgPath),
		UIEffectManager.instance:getEffectPath(ScuffleMainViewPresentor.MainViewBgPath),
		UIEffectManager.instance:getEffectPath(ScuffleMainViewPresentor.ScoreUpPath)
	}
end

function ScuffleMainViewPresentor:buildViews()
	return {
		ScuffleMainView.New()
	}
end

return ScuffleMainViewPresentor
