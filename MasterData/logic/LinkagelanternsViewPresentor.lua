-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkagelanternsViewPresentor.lua

module("logic.extensions.linkageintroduction.view.LinkagelanternsViewPresentor", package.seeall)

local LinkagelanternsViewPresentor = class("LinkagelanternsViewPresentor", ViewPresentor)

function LinkagelanternsViewPresentor:ctor()
	LinkagelanternsViewPresentor.super.ctor(self)
end

function LinkagelanternsViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkagelanternsViewPresentor:dependWhatResources()
	return {
		"ui/views/linkageintroduction/linkagelanternsview.prefab"
	}
end

function LinkagelanternsViewPresentor:buildViews()
	return {
		LinkagelanternsView.New()
	}
end

return LinkagelanternsViewPresentor
