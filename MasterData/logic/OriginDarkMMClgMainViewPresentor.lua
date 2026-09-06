-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/view/OriginDarkMMClgMainViewPresentor.lua

module("logic.extensions.origindarkmmclg.view.OriginDarkMMClgMainViewPresentor", package.seeall)

local OriginDarkMMClgMainViewPresentor = class("OriginDarkMMClgMainViewPresentor", ViewPresentor)

function OriginDarkMMClgMainViewPresentor:ctor()
	OriginDarkMMClgMainViewPresentor.super.ctor(self)
end

function OriginDarkMMClgMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OriginDarkMMClgMainViewPresentor:dependWhatResources()
	return {
		"ui/views/origindarkmmclg/origindarkmmclgmainview.prefab"
	}
end

function OriginDarkMMClgMainViewPresentor:buildViews()
	return {
		OriginDarkMMClgMainView.New()
	}
end

return OriginDarkMMClgMainViewPresentor
