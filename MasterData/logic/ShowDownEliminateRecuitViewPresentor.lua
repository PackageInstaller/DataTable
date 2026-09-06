-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownEliminateRecuitViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownEliminateRecuitViewPresentor", package.seeall)

local ShowDownEliminateRecuitViewPresentor = class("ShowDownEliminateRecuitViewPresentor", ViewPresentor)

function ShowDownEliminateRecuitViewPresentor:ctor()
	ShowDownEliminateRecuitViewPresentor.super.ctor(self)
end

function ShowDownEliminateRecuitViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShowDownEliminateRecuitViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdowneliminaterecuitview.prefab"
	}
end

function ShowDownEliminateRecuitViewPresentor:buildViews()
	return {
		ShowDownEliminateRecuitView.New()
	}
end

return ShowDownEliminateRecuitViewPresentor
