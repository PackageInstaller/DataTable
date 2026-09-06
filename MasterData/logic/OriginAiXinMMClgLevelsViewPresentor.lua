-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaixinmmclg/view/OriginAiXinMMClgLevelsViewPresentor.lua

module("logic.extensions.originaixinmmclg.view.OriginAiXinMMClgLevelsViewPresentor", package.seeall)

local OriginAiXinMMClgLevelsViewPresentor = class("OriginAiXinMMClgLevelsViewPresentor", ViewPresentor)

function OriginAiXinMMClgLevelsViewPresentor:ctor()
	OriginAiXinMMClgLevelsViewPresentor.super.ctor(self)
end

function OriginAiXinMMClgLevelsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginAiXinMMClgLevelsViewPresentor:dependWhatResources()
	return {
		"ui/views/originaixinmmclg/originaixinmmclglevelsview.prefab"
	}
end

function OriginAiXinMMClgLevelsViewPresentor:buildViews()
	return {
		OriginAiXinMMClgLevelsView.New()
	}
end

return OriginAiXinMMClgLevelsViewPresentor
