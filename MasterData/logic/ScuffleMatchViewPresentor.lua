-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScuffleMatchViewPresentor.lua

module("logic.extensions.scuffle.view.ScuffleMatchViewPresentor", package.seeall)

local ScuffleMatchViewPresentor = class("ScuffleMatchViewPresentor", ViewPresentor)

ScuffleMatchViewPresentor.VSPath = "fx_ui_jinglingdaluandou/fx_ui_pipei_vs.prefab"
ScuffleMatchViewPresentor.IngPath = "fx_ui_jinglingdaluandou/fx_ui_pipei_ing.prefab"
ScuffleMatchViewPresentor.SuccessPath = "fx_ui_jinglingdaluandou/fx_ui_pipeichenggong.prefab"

function ScuffleMatchViewPresentor:ctor()
	ScuffleMatchViewPresentor.super.ctor(self)
end

function ScuffleMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ScuffleMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/scuffle/scufflematchview.prefab"
	}
end

function ScuffleMatchViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(ScuffleMatchViewPresentor.VSPath),
		UIEffectManager.instance:getEffectPath(ScuffleMatchViewPresentor.IngPath),
		UIEffectManager.instance:getEffectPath(ScuffleMatchViewPresentor.SuccessPath)
	}
end

function ScuffleMatchViewPresentor:buildViews()
	return {
		ScuffleMatchView.New()
	}
end

return ScuffleMatchViewPresentor
