-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/view/ProjectAshBuffViewPresentor.lua

module("logic.extensions.projectash.view.ProjectAshBuffViewPresentor", package.seeall)

local ProjectAshBuffViewPresentor = class("ProjectAshBuffViewPresentor", ViewPresentor)

function ProjectAshBuffViewPresentor:ctor()
	ProjectAshBuffViewPresentor.super.ctor(self)
end

function ProjectAshBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ProjectAshBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/projectash/projectashbuffview.prefab"
	}
end

function ProjectAshBuffViewPresentor:buildViews()
	return {
		ProjectAshBuffView.New()
	}
end

return ProjectAshBuffViewPresentor
