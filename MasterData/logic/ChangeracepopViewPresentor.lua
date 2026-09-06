-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/ChangeracepopViewPresentor.lua

module("logic.extensions.formation.view.ChangeracepopViewPresentor", package.seeall)

local ChangeracepopViewPresentor = class("ChangeracepopViewPresentor", ViewWithGuidePresentor)

function ChangeracepopViewPresentor:ctor()
	ChangeracepopViewPresentor.super.ctor(self)
end

function ChangeracepopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ChangeracepopViewPresentor:dependWhatResources()
	return {
		"ui/views/formation/changeracepopview.prefab"
	}
end

function ChangeracepopViewPresentor:buildViews()
	return {
		ChangeracepopView.New()
	}
end

return ChangeracepopViewPresentor
