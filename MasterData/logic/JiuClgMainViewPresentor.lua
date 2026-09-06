-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgMainViewPresentor.lua

module("logic.extensions.jiuclg.view.JiuClgMainViewPresentor", package.seeall)

local JiuClgMainViewPresentor = class("JiuClgMainViewPresentor", ViewPresentor)

function JiuClgMainViewPresentor:ctor()
	JiuClgMainViewPresentor.super.ctor(self)
end

function JiuClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JiuClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/jiuclg/jiuclgmainview.prefab"
	}
end

function JiuClgMainViewPresentor:buildViews()
	return {
		JiuClgMainView.New()
	}
end

return JiuClgMainViewPresentor
