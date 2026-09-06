-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgChangeViewPresentor.lua

module("logic.extensions.jiuclg.view.JiuClgChangeViewPresentor", package.seeall)

local JiuClgChangeViewPresentor = class("JiuClgChangeViewPresentor", ViewPresentor)

function JiuClgChangeViewPresentor:ctor()
	JiuClgChangeViewPresentor.super.ctor(self)
end

function JiuClgChangeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JiuClgChangeViewPresentor:dependWhatResources()
	return {
		"ui/views/jiuclg/jiuclgchangeview.prefab"
	}
end

function JiuClgChangeViewPresentor:buildViews()
	return {
		JiuClgChangeView.New()
	}
end

return JiuClgChangeViewPresentor
