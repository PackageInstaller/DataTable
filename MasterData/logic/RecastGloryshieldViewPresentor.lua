-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGloryshieldViewPresentor.lua

module("logic.extensions.recastglory.view.RecastGloryshieldViewPresentor", package.seeall)

local RecastGloryshieldViewPresentor = class("RecastGloryshieldViewPresentor", ViewPresentor)

function RecastGloryshieldViewPresentor:ctor()
	RecastGloryshieldViewPresentor.super.ctor(self)
end

function RecastGloryshieldViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RecastGloryshieldViewPresentor:dependWhatResources()
	return {
		"ui/views/recastglory/recastgloryshieldview.prefab"
	}
end

function RecastGloryshieldViewPresentor:buildViews()
	return {
		RecastGloryshieldView.New()
	}
end

return RecastGloryshieldViewPresentor
