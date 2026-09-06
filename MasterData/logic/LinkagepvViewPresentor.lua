-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkagepvViewPresentor.lua

module("logic.extensions.linkageintroduction.view.LinkagepvViewPresentor", package.seeall)

local LinkagepvViewPresentor = class("LinkagepvViewPresentor", ViewPresentor)

function LinkagepvViewPresentor:ctor()
	LinkagepvViewPresentor.super.ctor(self)
end

function LinkagepvViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkagepvViewPresentor:dependWhatResources()
	return {
		"ui/views/linkageintroduction/linkagepvview.prefab"
	}
end

function LinkagepvViewPresentor:buildViews()
	return {
		LinkagepvView.New()
	}
end

return LinkagepvViewPresentor
