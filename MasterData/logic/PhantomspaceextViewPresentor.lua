-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspaceextViewPresentor.lua

module("logic.extensions.phantomspace.view.PhantomspaceextViewPresentor", package.seeall)

local PhantomspaceextViewPresentor = class("PhantomspaceextViewPresentor", ViewPresentor)

function PhantomspaceextViewPresentor:ctor()
	PhantomspaceextViewPresentor.super.ctor(self)
end

function PhantomspaceextViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PhantomspaceextViewPresentor:dependWhatResources()
	return {
		"ui/views/phantomspace/phantomspaceextview.prefab"
	}
end

function PhantomspaceextViewPresentor:buildViews()
	return {
		PhantomspaceextView.New()
	}
end

return PhantomspaceextViewPresentor
