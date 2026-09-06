-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideForeDragViewPresentor.lua

module("logic.extensions.guide.view.GuideForeDragViewPresentor", package.seeall)

local GuideForeDragViewPresentor = class("GuideForeDragViewPresentor", GuideViewPresentor)

function GuideForeDragViewPresentor:ctor()
	GuideForeDragViewPresentor.super.ctor(self)
end

function GuideForeDragViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GuideForeDragViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_force_drag.prefab"
	}
end

function GuideForeDragViewPresentor:buildViews()
	return {
		GuideForeDragView.New()
	}
end

return GuideForeDragViewPresentor
