-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenvsjiu/view/JieShenVsJiuGameViewPresentor.lua

module("logic.extensions.jieshenvsjiu.view.JieShenVsJiuGameViewPresentor", package.seeall)

local JieShenVsJiuGameViewPresentor = class("JieShenVsJiuGameViewPresentor", ViewPresentor)

function JieShenVsJiuGameViewPresentor:ctor()
	JieShenVsJiuGameViewPresentor.super.ctor(self)
end

function JieShenVsJiuGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JieShenVsJiuGameViewPresentor:dependWhatResources()
	return {
		"ui/views/jieshenvsjiu/jieshenvsjiugameview.prefab"
	}
end

function JieShenVsJiuGameViewPresentor:buildViews()
	return {
		JieShenVsJiuGameView.New()
	}
end

return JieShenVsJiuGameViewPresentor
