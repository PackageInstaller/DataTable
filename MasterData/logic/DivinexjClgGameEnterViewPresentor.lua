-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgGameEnterViewPresentor.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgGameEnterViewPresentor", package.seeall)

local DivinexjClgGameEnterViewPresentor = class("DivinexjClgGameEnterViewPresentor", ViewPresentor)

DivinexjClgGameEnterViewPresentor.EffectPath = "20240430/syxjtiaozhan/fx_ui_syxjtz_dianji.prefab"

function DivinexjClgGameEnterViewPresentor:ctor()
	DivinexjClgGameEnterViewPresentor.super.ctor(self)
end

function DivinexjClgGameEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexjClgGameEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexingjiangclg/divinexjclggameenterview.prefab"
	}
end

function DivinexjClgGameEnterViewPresentor:buildViews()
	return {
		DivinexjClgGameEnterView.New()
	}
end

function DivinexjClgGameEnterViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(DivinexjClgGameEnterViewPresentor.EffectPath)
	}
end

return DivinexjClgGameEnterViewPresentor
