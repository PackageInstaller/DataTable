-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspacemainViewPresentor.lua

module("logic.extensions.phantomspace.view.PhantomspacemainViewPresentor", package.seeall)

local PhantomspacemainViewPresentor = class("PhantomspacemainViewPresentor", ViewPresentor)

function PhantomspacemainViewPresentor:ctor()
	PhantomspacemainViewPresentor.super.ctor(self)
end

function PhantomspacemainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PhantomspacemainViewPresentor:dependWhatResources()
	return {
		"ui/views/phantomspace/phantomspacemainview.prefab"
	}
end

function PhantomspacemainViewPresentor:buildViews()
	return {
		PhantomspacemainView.New()
	}
end

return PhantomspacemainViewPresentor
