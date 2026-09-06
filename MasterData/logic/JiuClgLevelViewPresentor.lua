-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgLevelViewPresentor.lua

module("logic.extensions.jiuclg.view.JiuClgLevelViewPresentor", package.seeall)

local JiuClgLevelViewPresentor = class("JiuClgLevelViewPresentor", ViewPresentor)

JiuClgLevelViewPresentor.BgPath1 = "ui/bigbg/views/challenges/jiuclg/bg_jiu_01.png"
JiuClgLevelViewPresentor.BgPath2 = "ui/bigbg/views/challenges/jiuclg/bg_jiu_02.png"

function JiuClgLevelViewPresentor:ctor()
	JiuClgLevelViewPresentor.super.ctor(self)
end

function JiuClgLevelViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JiuClgLevelViewPresentor:dependWhatResources()
	return {
		"ui/views/jiuclg/jiuclglevelview.prefab"
	}
end

function JiuClgLevelViewPresentor:buildViews()
	return {
		JiuClgLevelView.New()
	}
end

function JiuClgLevelViewPresentor:getTempResources()
	return {
		JiuClgLevelViewPresentor.BgPath1,
		JiuClgLevelViewPresentor.BgPath2
	}
end

return JiuClgLevelViewPresentor
