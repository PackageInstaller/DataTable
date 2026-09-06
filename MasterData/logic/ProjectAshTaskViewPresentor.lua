-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshTaskViewPresentor.lua

module("logic.extensions.projectash.view.ProjectAshTaskViewPresentor", package.seeall)

local ProjectAshTaskViewPresentor = class("ProjectAshTaskViewPresentor", ViewPresentor)

function ProjectAshTaskViewPresentor:ctor()
	ProjectAshTaskViewPresentor.super.ctor(self)
end

function ProjectAshTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ProjectAshTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/projectash/projectashtaskview.prefab"
	}
end

function ProjectAshTaskViewPresentor:buildViews()
	return {
		ProjectAshTaskView.New()
	}
end

return ProjectAshTaskViewPresentor
