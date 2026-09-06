-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/view/OriginDarkMMClgActionValueViewPresentor.lua

module("logic.extensions.origindarkmmclg.view.OriginDarkMMClgActionValueViewPresentor", package.seeall)

local OriginDarkMMClgActionValueViewPresentor = class("OriginDarkMMClgActionValueViewPresentor", ViewPresentor)

function OriginDarkMMClgActionValueViewPresentor:ctor()
	OriginDarkMMClgActionValueViewPresentor.super.ctor(self)
end

function OriginDarkMMClgActionValueViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function OriginDarkMMClgActionValueViewPresentor:dependWhatResources()
	return {
		"ui/views/origindarkmmclg/origindarkmmclgactionvalueview.prefab"
	}
end

function OriginDarkMMClgActionValueViewPresentor:buildViews()
	return {
		OriginDarkMMClgActionValueView.New()
	}
end

return OriginDarkMMClgActionValueViewPresentor
