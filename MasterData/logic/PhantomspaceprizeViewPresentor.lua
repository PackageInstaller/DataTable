-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspaceprizeViewPresentor.lua

module("logic.extensions.phantomspace.view.PhantomspaceprizeViewPresentor", package.seeall)

local PhantomspaceprizeViewPresentor = class("PhantomspaceprizeViewPresentor", ViewPresentor)

function PhantomspaceprizeViewPresentor:ctor()
	PhantomspaceprizeViewPresentor.super.ctor(self)
end

function PhantomspaceprizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PhantomspaceprizeViewPresentor:dependWhatResources()
	return {
		"ui/views/phantomspace/phantomspaceprizeview.prefab"
	}
end

function PhantomspaceprizeViewPresentor:buildViews()
	return {
		PhantomspaceprizeView.New()
	}
end

return PhantomspaceprizeViewPresentor
