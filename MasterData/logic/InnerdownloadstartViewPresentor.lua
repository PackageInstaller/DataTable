-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/innerdownload/view/InnerdownloadstartViewPresentor.lua

module("logic.extensions.innerdownload.view.InnerdownloadstartViewPresentor", package.seeall)

local InnerdownloadstartViewPresentor = class("InnerdownloadstartViewPresentor", ViewPresentor)

function InnerdownloadstartViewPresentor:ctor()
	InnerdownloadstartViewPresentor.super.ctor(self)
end

function InnerdownloadstartViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InnerdownloadstartViewPresentor:dependWhatResources()
	return {
		"ui/views/innerdownload/innerdownloadstartview.prefab"
	}
end

function InnerdownloadstartViewPresentor:buildViews()
	return {
		InnerdownloadstartView.New()
	}
end

return InnerdownloadstartViewPresentor
