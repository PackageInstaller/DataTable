-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/view/LTDaJiaoMainViewPresentor.lua

module("logic.extensions.luotiandajiao.view.LTDaJiaoMainViewPresentor", package.seeall)

local LTDaJiaoMainViewPresentor = class("LTDaJiaoMainViewPresentor", ViewPresentor)

function LTDaJiaoMainViewPresentor:ctor()
	LTDaJiaoMainViewPresentor.super.ctor(self)
end

function LTDaJiaoMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LTDaJiaoMainViewPresentor:dependWhatResources()
	return {
		"ui/views/luotiandajiao/ltdajiaomainview.prefab"
	}
end

function LTDaJiaoMainViewPresentor:buildViews()
	return {
		LTDaJiaoMainView.New()
	}
end

return LTDaJiaoMainViewPresentor
