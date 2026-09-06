-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideMaskViewPresentor.lua

module("logic.extensions.guide.view.GuideMaskViewPresentor", package.seeall)

local GuideMaskViewPresentor = class("GuideMaskViewPresentor", ViewPresentor)

function GuideMaskViewPresentor:ctor()
	GuideMaskViewPresentor.super.ctor(self)
end

function GuideMaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuideMaskViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_mask_view.prefab"
	}
end

function GuideMaskViewPresentor:buildViews()
	return {
		GuideMaskView.New()
	}
end

return GuideMaskViewPresentor
