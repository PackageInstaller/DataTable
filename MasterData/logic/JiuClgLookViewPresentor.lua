-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiuclg/view/JiuClgLookViewPresentor.lua

module("logic.extensions.jiuclg.view.JiuClgLookViewPresentor", package.seeall)

local JiuClgLookViewPresentor = class("JiuClgLookViewPresentor", ViewPresentor)

function JiuClgLookViewPresentor:ctor()
	JiuClgLookViewPresentor.super.ctor(self)
end

function JiuClgLookViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function JiuClgLookViewPresentor:dependWhatResources()
	return {
		"ui/views/jiuclg/jiuclglookview.prefab"
	}
end

function JiuClgLookViewPresentor:buildViews()
	return {
		JiuClgLookView.New()
	}
end

return JiuClgLookViewPresentor
