-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshRewardViewPresentor.lua

module("logic.extensions.projectash.view.ProjectAshRewardViewPresentor", package.seeall)

local ProjectAshRewardViewPresentor = class("ProjectAshRewardViewPresentor", ViewPresentor)

function ProjectAshRewardViewPresentor:ctor()
	ProjectAshRewardViewPresentor.super.ctor(self)
end

function ProjectAshRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ProjectAshRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/projectash/projectashrewardview.prefab"
	}
end

function ProjectAshRewardViewPresentor:buildViews()
	return {
		ProjectAshRewardView.New()
	}
end

return ProjectAshRewardViewPresentor
