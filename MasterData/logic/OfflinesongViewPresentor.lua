-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/offline/view/OfflinesongViewPresentor.lua

module("logic.extensions.offline.view.OfflinesongViewPresentor", package.seeall)

local OfflinesongViewPresentor = class("OfflinesongViewPresentor", ViewPresentor)

function OfflinesongViewPresentor:ctor()
	OfflinesongViewPresentor.super.ctor(self)
end

function OfflinesongViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function OfflinesongViewPresentor:dependWhatResources()
	return {
		"ui/views/offline/offlinesongview.prefab"
	}
end

function OfflinesongViewPresentor:buildViews()
	return {
		OfflinesongView.New()
	}
end

return OfflinesongViewPresentor
