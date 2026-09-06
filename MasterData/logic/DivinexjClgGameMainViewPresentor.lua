-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgGameMainViewPresentor.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgGameMainViewPresentor", package.seeall)

local DivinexjClgGameMainViewPresentor = class("DivinexjClgGameMainViewPresentor", ViewPresentor)

DivinexjClgGameMainViewPresentor.EffectPath = "20240430/syxjtiaozhan/fx_ui_syxjtz_shouji.prefab"

function DivinexjClgGameMainViewPresentor:ctor()
	DivinexjClgGameMainViewPresentor.super.ctor(self)
end

function DivinexjClgGameMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivinexjClgGameMainViewPresentor:dependWhatResources()
	return {
		"ui/views/divinexingjiangclg/divinexjclggamemainview.prefab"
	}
end

function DivinexjClgGameMainViewPresentor:buildViews()
	return {
		DivinexjClgGameMainView.New()
	}
end

function DivinexjClgGameMainViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(DivinexjClgGameMainViewPresentor.EffectPath)
	}
end

return DivinexjClgGameMainViewPresentor
