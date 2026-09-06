-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenvsjiu/view/JieshenvsjiuViewPresentor.lua

module("logic.extensions.jieshenvsjiu.view.JieshenvsjiuViewPresentor", package.seeall)

local JieshenvsjiuViewPresentor = class("JieshenvsjiuViewPresentor", ViewPresentor)

JieshenvsjiuViewPresentor.MainViewBgPath = "20240726/jieshenvsjiu/fx_ui_jieshenvsjiu.prefab"

function JieshenvsjiuViewPresentor:ctor()
	JieshenvsjiuViewPresentor.super.ctor(self)
end

function JieshenvsjiuViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieshenvsjiuViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenvsjiu/jieshenvsjiuview.prefab"
	}
end

function JieshenvsjiuViewPresentor:buildViews()
	return {
		JieshenvsjiuView.New()
	}
end

function JieshenvsjiuViewPresentor:getTempResources()
	return {
		UIEffectManager.instance:getEffectPath(JieshenvsjiuViewPresentor.MainViewBgPath)
	}
end

return JieshenvsjiuViewPresentor
