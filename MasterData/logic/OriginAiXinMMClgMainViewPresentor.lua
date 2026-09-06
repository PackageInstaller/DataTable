-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaixinmmclg/view/OriginAiXinMMClgMainViewPresentor.lua

module("logic.extensions.originaixinmmclg.view.OriginAiXinMMClgMainViewPresentor", package.seeall)

local OriginAiXinMMClgMainViewPresentor = class("OriginAiXinMMClgMainViewPresentor", ViewPresentor)

function OriginAiXinMMClgMainViewPresentor:ctor()
	OriginAiXinMMClgMainViewPresentor.super.ctor(self)
end

function OriginAiXinMMClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAiXinMMClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/originaixinmmclg/originaixinmmclgmainview.prefab"
	}
end

function OriginAiXinMMClgMainViewPresentor:buildViews()
	return {
		OriginAiXinMMClgMainView.New()
	}
end

return OriginAiXinMMClgMainViewPresentor
