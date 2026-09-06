-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideForeDragChangePosViewPresentor.lua

module("logic.extensions.guide.view.GuideForeDragChangePosViewPresentor", package.seeall)

local GuideForeDragChangePosViewPresentor = class("GuideForeDragChangePosViewPresentor", GuideViewPresentor)

function GuideForeDragChangePosViewPresentor:ctor()
	GuideForeDragChangePosViewPresentor.super.ctor(self)
end

function GuideForeDragChangePosViewPresentor:attachToWhichRoot()
	return ViewRootType.Top
end

function GuideForeDragChangePosViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_force_drag_change.prefab"
	}
end

function GuideForeDragChangePosViewPresentor:buildViews()
	return {
		GuideForeDragChangePosView.New()
	}
end

return GuideForeDragChangePosViewPresentor
