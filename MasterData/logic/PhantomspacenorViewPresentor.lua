-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspacenorViewPresentor.lua

module("logic.extensions.phantomspace.view.PhantomspacenorViewPresentor", package.seeall)

local PhantomspacenorViewPresentor = class("PhantomspacenorViewPresentor", ViewPresentor)

function PhantomspacenorViewPresentor:ctor()
	PhantomspacenorViewPresentor.super.ctor(self)
end

function PhantomspacenorViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PhantomspacenorViewPresentor:dependWhatResources()
	return {
		"ui/views/phantomspace/phantomspacenorview.prefab"
	}
end

function PhantomspacenorViewPresentor:buildViews()
	return {
		PhantomspacenorView.New()
	}
end

return PhantomspacenorViewPresentor
