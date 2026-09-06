-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/divinemiuke/DivineMiuKeClgBuildViewPresentor.lua

module("logic.extensions.watertianyan.view.divinemiuke.DivineMiuKeClgBuildViewPresentor", package.seeall)

local DivineMiuKeClgBuildViewPresentor = class("DivineMiuKeClgBuildViewPresentor", ViewPresentor)

function DivineMiuKeClgBuildViewPresentor:ctor()
	DivineMiuKeClgBuildViewPresentor.super.ctor(self)
end

function DivineMiuKeClgBuildViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DivineMiuKeClgBuildViewPresentor:dependWhatResources()
	return {
		"ui/views/watertianyan/divinemiuke/divinemiukeclgbuildview.prefab"
	}
end

function DivineMiuKeClgBuildViewPresentor:buildViews()
	return {
		DivineMiuKeClgBuildView.New()
	}
end

return DivineMiuKeClgBuildViewPresentor
