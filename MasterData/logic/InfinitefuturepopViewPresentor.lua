-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinitefuturepopViewPresentor.lua

module("logic.extensions.infinitefuture.view.InfinitefuturepopViewPresentor", package.seeall)

local InfinitefuturepopViewPresentor = class("InfinitefuturepopViewPresentor", ViewPresentor)

function InfinitefuturepopViewPresentor:ctor()
	InfinitefuturepopViewPresentor.super.ctor(self)
end

function InfinitefuturepopViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function InfinitefuturepopViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/infinitefuturepopview.prefab"
	}
end

function InfinitefuturepopViewPresentor:buildViews()
	return {
		InfinitefuturepopView.New()
	}
end

return InfinitefuturepopViewPresentor
