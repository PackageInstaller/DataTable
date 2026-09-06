-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/view/LTDaJiaoEnterViewPresentor.lua

module("logic.extensions.luotiandajiao.view.LTDaJiaoEnterViewPresentor", package.seeall)

local LTDaJiaoEnterViewPresentor = class("LTDaJiaoEnterViewPresentor", ViewPresentor)

function LTDaJiaoEnterViewPresentor:ctor()
	LTDaJiaoEnterViewPresentor.super.ctor(self)
end

function LTDaJiaoEnterViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LTDaJiaoEnterViewPresentor:dependWhatResources()
	return {
		"ui/views/luotiandajiao/ltdajiaoenterview.prefab"
	}
end

function LTDaJiaoEnterViewPresentor:buildViews()
	return {
		LTDaJiaoEnterView.New()
	}
end

return LTDaJiaoEnterViewPresentor
