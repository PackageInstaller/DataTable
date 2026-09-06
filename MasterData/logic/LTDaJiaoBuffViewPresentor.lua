-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/view/LTDaJiaoBuffViewPresentor.lua

module("logic.extensions.luotiandajiao.view.LTDaJiaoBuffViewPresentor", package.seeall)

local LTDaJiaoBuffViewPresentor = class("LTDaJiaoBuffViewPresentor", ViewPresentor)

function LTDaJiaoBuffViewPresentor:ctor()
	LTDaJiaoBuffViewPresentor.super.ctor(self)
end

function LTDaJiaoBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function LTDaJiaoBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/luotiandajiao/ltdajiaobuffview.prefab"
	}
end

function LTDaJiaoBuffViewPresentor:buildViews()
	return {
		LTDaJiaoBuffView.New()
	}
end

return LTDaJiaoBuffViewPresentor
