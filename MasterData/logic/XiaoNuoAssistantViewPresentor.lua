-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/view/XiaoNuoAssistantViewPresentor.lua

module("logic.extensions.xiaonuoassistant.view.XiaoNuoAssistantViewPresentor", package.seeall)

local XiaoNuoAssistantViewPresentor = class("XiaoNuoAssistantViewPresentor", ViewPresentor)

function XiaoNuoAssistantViewPresentor:ctor()
	XiaoNuoAssistantViewPresentor.super.ctor(self)
end

function XiaoNuoAssistantViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function XiaoNuoAssistantViewPresentor:dependWhatResources()
	return {
		"ui/views/xiaonuoassistant/xiaonuoassistantview.prefab"
	}
end

function XiaoNuoAssistantViewPresentor:buildViews()
	return {
		XiaoNuoAssistantView.New()
	}
end

return XiaoNuoAssistantViewPresentor
