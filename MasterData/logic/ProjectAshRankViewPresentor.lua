-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshRankViewPresentor.lua

module("logic.extensions.projectash.view.ProjectAshRankViewPresentor", package.seeall)

local ProjectAshRankViewPresentor = class("ProjectAshRankViewPresentor", ViewPresentor)

function ProjectAshRankViewPresentor:ctor()
	ProjectAshRankViewPresentor.super.ctor(self)
end

function ProjectAshRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ProjectAshRankViewPresentor:dependWhatResources()
	return {
		"ui/views/projectash/projectashrankview.prefab"
	}
end

function ProjectAshRankViewPresentor:buildViews()
	return {
		ProjectAshRankView.New()
	}
end

return ProjectAshRankViewPresentor
