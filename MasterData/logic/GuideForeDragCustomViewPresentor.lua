-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideForeDragCustomViewPresentor.lua

module("logic.extensions.guide.view.GuideForeDragCustomViewPresentor", package.seeall)

local GuideForeDragCustomViewPresentor = class("GuideForeDragCustomViewPresentor", GuideViewPresentor)

function GuideForeDragCustomViewPresentor:ctor()
	GuideForeDragCustomViewPresentor.super.ctor(self)
end

function GuideForeDragCustomViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GuideForeDragCustomViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_force_drag.prefab"
	}
end

function GuideForeDragCustomViewPresentor:buildViews()
	return {
		GuideForeDragCustomView.New()
	}
end

return GuideForeDragCustomViewPresentor
