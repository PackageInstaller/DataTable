-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanmainViewPresentor.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanmainViewPresentor", package.seeall)

local SixartdaoguanmainViewPresentor = class("SixartdaoguanmainViewPresentor", ViewPresentor)

function SixartdaoguanmainViewPresentor:ctor()
	SixartdaoguanmainViewPresentor.super.ctor(self)
end

function SixartdaoguanmainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function SixartdaoguanmainViewPresentor:dependWhatResources()
	return {
		"ui/views/sixartdaoguan/sixartdaoguanmainview.prefab"
	}
end

function SixartdaoguanmainViewPresentor:buildViews()
	return {
		SixartdaoguanmainView.New()
	}
end

return SixartdaoguanmainViewPresentor
