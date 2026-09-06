-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastglorybreakthroughViewPresentor.lua

module("logic.extensions.recastglory.view.RecastglorybreakthroughViewPresentor", package.seeall)

local RecastglorybreakthroughViewPresentor = class("RecastglorybreakthroughViewPresentor", ViewPresentor)

function RecastglorybreakthroughViewPresentor:ctor()
	RecastglorybreakthroughViewPresentor.super.ctor(self)
end

function RecastglorybreakthroughViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RecastglorybreakthroughViewPresentor:dependWhatResources()
	return {
		"ui/views/recastglory/recastglorybreakthroughview.prefab"
	}
end

function RecastglorybreakthroughViewPresentor:buildViews()
	return {
		RecastGlorybreakthroughView.New()
	}
end

return RecastglorybreakthroughViewPresentor
