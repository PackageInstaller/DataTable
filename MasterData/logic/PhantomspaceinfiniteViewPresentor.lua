-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspaceinfiniteViewPresentor.lua

module("logic.extensions.phantomspace.view.PhantomspaceinfiniteViewPresentor", package.seeall)

local PhantomspaceinfiniteViewPresentor = class("PhantomspaceinfiniteViewPresentor", ViewPresentor)

function PhantomspaceinfiniteViewPresentor:ctor()
	PhantomspaceinfiniteViewPresentor.super.ctor(self)
end

function PhantomspaceinfiniteViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PhantomspaceinfiniteViewPresentor:dependWhatResources()
	return {
		"ui/views/phantomspace/phantomspaceinfiniteview.prefab"
	}
end

function PhantomspaceinfiniteViewPresentor:buildViews()
	return {
		PhantomspaceinfiniteView.New()
	}
end

return PhantomspaceinfiniteViewPresentor
