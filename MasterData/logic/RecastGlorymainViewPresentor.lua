-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGlorymainViewPresentor.lua

module("logic.extensions.recastglory.view.RecastGlorymainViewPresentor", package.seeall)

local RecastGlorymainViewPresentor = class("RecastGlorymainViewPresentor", ViewPresentor)

function RecastGlorymainViewPresentor:ctor()
	RecastGlorymainViewPresentor.super.ctor(self)
end

function RecastGlorymainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function RecastGlorymainViewPresentor:dependWhatResources()
	return {
		"ui/views/recastglory/recastglorymainview.prefab"
	}
end

function RecastGlorymainViewPresentor:buildViews()
	return {
		RecastGlorymainView.New()
	}
end

return RecastGlorymainViewPresentor
