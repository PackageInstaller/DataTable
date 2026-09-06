-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleBanViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleBanViewPresentor", package.seeall)

local ScuffleBanViewPresentor = class("ScuffleBanViewPresentor", ViewPresentor)

ScuffleBanViewPresentor.BluePath = "fx_ui_jinglingdaluandou/fx_ui_fapaixiaoguo_bule.prefab"
ScuffleBanViewPresentor.RedPath = "fx_ui_jinglingdaluandou/fx_ui_fapaixiaoguo_red.prefab"

function ScuffleBanViewPresentor:ctor()
	ScuffleBanViewPresentor.super.ctor(self)
end

function ScuffleBanViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleBanViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflebanview.prefab"
	}
end

function ScuffleBanViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(ScuffleBanViewPresentor.BluePath),
		UIEffectManager.instance:getEffectPath(ScuffleBanViewPresentor.RedPath)
	}
end

function ScuffleBanViewPresentor:buildViews()
	return {
		ScuffleBanView.New()
	}
end

return ScuffleBanViewPresentor
