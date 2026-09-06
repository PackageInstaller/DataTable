-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/view/OriginDarkMMClgStageViewPresentor.lua

module("logic.extensions.origindarkmmclg.view.OriginDarkMMClgStageViewPresentor", package.seeall)

local OriginDarkMMClgStageViewPresentor = class("OriginDarkMMClgStageViewPresentor", ViewPresentor)

function OriginDarkMMClgStageViewPresentor:ctor()
	OriginDarkMMClgStageViewPresentor.super.ctor(self)
end

function OriginDarkMMClgStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDarkMMClgStageViewPresentor:dependWhatResources()
	return {
		"ui/views/origindarkmmclg/origindarkmmclgstageview.prefab"
	}
end

function OriginDarkMMClgStageViewPresentor:buildViews()
	return {
		OriginDarkMMClgStageView.New()
	}
end

return OriginDarkMMClgStageViewPresentor
