-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateCreateViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownEliminateCreateViewPresentor", package.seeall)

local ShowDownEliminateCreateViewPresentor = class("ShowDownEliminateCreateViewPresentor", ViewPresentor)

function ShowDownEliminateCreateViewPresentor:ctor()
	ShowDownEliminateCreateViewPresentor.super.ctor(self)
end

function ShowDownEliminateCreateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownEliminateCreateViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminatecreateview.prefab"
	}
end

function ShowDownEliminateCreateViewPresentor:buildViews()
	return {
		ShowDownEliminateCreateView.New()
	}
end

return ShowDownEliminateCreateViewPresentor
