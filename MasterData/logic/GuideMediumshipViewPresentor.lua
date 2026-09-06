-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuideMediumshipViewPresentor.lua

module("logic.extensions.guide.view.GuideMediumshipViewPresentor", package.seeall)

local GuideMediumshipViewPresentor = class("GuideMediumshipViewPresentor", ViewWithGuidePresentor)

function GuideMediumshipViewPresentor:ctor()
	GuideMediumshipViewPresentor.super.ctor(self)
end

function GuideMediumshipViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GuideMediumshipViewPresentor:dependWhatResources()
	return {
		"ui/views/guide/guide_mediumship.prefab"
	}
end

function GuideMediumshipViewPresentor:buildViews()
	return {
		GuideMediumshipView.New()
	}
end

function GuideMediumshipViewPresentor:setGrayMaskGO(grayMaskGO)
	GuideMediumshipViewPresentor.super.setGrayMaskGO(self, grayMaskGO)
	GameUtil.SetActive(grayMaskGO, false)
end

return GuideMediumshipViewPresentor
