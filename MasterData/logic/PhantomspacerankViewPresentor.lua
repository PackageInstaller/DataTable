-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/phantomspace/view/PhantomspacerankViewPresentor.lua

module("logic.extensions.phantomspace.view.PhantomspacerankViewPresentor", package.seeall)

local PhantomspacerankViewPresentor = class("PhantomspacerankViewPresentor", ViewPresentor)

function PhantomspacerankViewPresentor:ctor()
	PhantomspacerankViewPresentor.super.ctor(self)
end

function PhantomspacerankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function PhantomspacerankViewPresentor:dependWhatResources()
	return {
		"ui/views/phantomspace/phantomspacerankview.prefab"
	}
end

function PhantomspacerankViewPresentor:buildViews()
	return {
		PhantomspacerankView.New()
	}
end

return PhantomspacerankViewPresentor
