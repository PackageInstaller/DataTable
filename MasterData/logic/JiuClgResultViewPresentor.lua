-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgResultViewPresentor.lua

module("logic.extensions.jiuclg.view.JiuClgResultViewPresentor", package.seeall)

local JiuClgResultViewPresentor = class("JiuClgResultViewPresentor", ViewPresentor)

function JiuClgResultViewPresentor:ctor()
	JiuClgResultViewPresentor.super.ctor(self)
end

function JiuClgResultViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JiuClgResultViewPresentor:dependWhatResources()
	return {
		"ui/views/jiuclg/jiuclgresultview.prefab"
	}
end

function JiuClgResultViewPresentor:buildViews()
	return {
		JiuClgResultView.New()
	}
end

return JiuClgResultViewPresentor
