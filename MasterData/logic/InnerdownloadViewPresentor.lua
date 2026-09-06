-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/innerdownload/view/InnerdownloadViewPresentor.lua

module("logic.extensions.innerdownload.view.InnerdownloadViewPresentor", package.seeall)

local InnerdownloadViewPresentor = class("InnerdownloadViewPresentor", ViewPresentor)

function InnerdownloadViewPresentor:ctor()
	InnerdownloadViewPresentor.super.ctor(self)
end

function InnerdownloadViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InnerdownloadViewPresentor:dependWhatResources()
	return {
		"ui/views/innerdownload/innerdownloadview.prefab"
	}
end

function InnerdownloadViewPresentor:buildViews()
	return {
		InnerdownloadView.New()
	}
end

return InnerdownloadViewPresentor
