-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/view/OriginDarkMMClgFmtViewPresentor.lua

module("logic.extensions.origindarkmmclg.view.OriginDarkMMClgFmtViewPresentor", package.seeall)

local OriginDarkMMClgFmtViewPresentor = class("OriginDarkMMClgFmtViewPresentor", ViewPresentor)

function OriginDarkMMClgFmtViewPresentor:ctor()
	OriginDarkMMClgFmtViewPresentor.super.ctor(self)
end

function OriginDarkMMClgFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDarkMMClgFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/origindarkmmclg/origindarkmmclgfmtview.prefab"
	}
end

function OriginDarkMMClgFmtViewPresentor:buildViews()
	return {
		OriginDarkMMClgFmtView.New()
	}
end

return OriginDarkMMClgFmtViewPresentor
