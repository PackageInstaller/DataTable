-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/generalworldprogress/view/GeneralWorldProgressTaskViewPresentor.lua

module("logic.extensions.generalworldprogress.view.GeneralWorldProgressTaskViewPresentor", package.seeall)

local GeneralWorldProgressTaskViewPresentor = class("GeneralWorldProgressTaskViewPresentor", ViewPresentor)

function GeneralWorldProgressTaskViewPresentor:ctor()
	GeneralWorldProgressTaskViewPresentor.super.ctor(self)
end

function GeneralWorldProgressTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function GeneralWorldProgressTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/generalworldprogress/generalworldprogresstaskview.prefab"
	}
end

function GeneralWorldProgressTaskViewPresentor:buildViews()
	return {
		GeneralWorldProgressTaskView.New()
	}
end

return GeneralWorldProgressTaskViewPresentor
