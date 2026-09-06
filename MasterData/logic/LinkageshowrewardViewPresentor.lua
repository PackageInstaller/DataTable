-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkageshowrewardViewPresentor.lua

module("logic.extensions.linkageintroduction.view.LinkageshowrewardViewPresentor", package.seeall)

local LinkageshowrewardViewPresentor = class("LinkageshowrewardViewPresentor", ViewPresentor)

function LinkageshowrewardViewPresentor:ctor()
	LinkageshowrewardViewPresentor.super.ctor(self)
end

function LinkageshowrewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function LinkageshowrewardViewPresentor:dependWhatResources()
	return {
		"ui/views/linkageintroduction/linkageshowrewardview.prefab"
	}
end

function LinkageshowrewardViewPresentor:buildViews()
	return {
		LinkageshowrewardView.New()
	}
end

return LinkageshowrewardViewPresentor
