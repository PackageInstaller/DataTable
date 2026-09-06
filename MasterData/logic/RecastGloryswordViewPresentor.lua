-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGloryswordViewPresentor.lua

module("logic.extensions.recastglory.view.RecastGloryswordViewPresentor", package.seeall)

local RecastGloryswordViewPresentor = class("RecastGloryswordViewPresentor", ViewPresentor)

function RecastGloryswordViewPresentor:ctor()
	RecastGloryswordViewPresentor.super.ctor(self)
end

function RecastGloryswordViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RecastGloryswordViewPresentor:dependWhatResources()
	return {
		"ui/views/recastglory/recastgloryswordview.prefab"
	}
end

function RecastGloryswordViewPresentor:buildViews()
	return {
		RecastGloryswordView.New()
	}
end

return RecastGloryswordViewPresentor
