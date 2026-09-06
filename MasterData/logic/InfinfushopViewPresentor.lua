-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfushopViewPresentor.lua

module("logic.extensions.infinitefuture.view.InfinfushopViewPresentor", package.seeall)

local InfinfushopViewPresentor = class("InfinfushopViewPresentor", ViewPresentor)

function InfinfushopViewPresentor:ctor()
	InfinfushopViewPresentor.super.ctor(self)
end

function InfinfushopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function InfinfushopViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/infinitefuture/infinfushopview.prefab"
	}
end

function InfinfushopViewPresentor:buildViews()
	return {
		InfinfushopView.New()
	}
end

return InfinfushopViewPresentor
