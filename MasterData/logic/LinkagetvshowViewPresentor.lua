-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkagetvshowViewPresentor.lua

module("logic.extensions.linkageintroduction.view.LinkagetvshowViewPresentor", package.seeall)

local LinkagetvshowViewPresentor = class("LinkagetvshowViewPresentor", ViewPresentor)

function LinkagetvshowViewPresentor:ctor()
	LinkagetvshowViewPresentor.super.ctor(self)
end

function LinkagetvshowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkagetvshowViewPresentor:dependWhatResources()
	return {
		"ui/views/linkageintroduction/linkagetvshowview.prefab"
	}
end

function LinkagetvshowViewPresentor:buildViews()
	return {
		LinkagetvshowView.New()
	}
end

return LinkagetvshowViewPresentor
