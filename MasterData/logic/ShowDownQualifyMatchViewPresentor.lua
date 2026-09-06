-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownQualifyMatchViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownQualifyMatchViewPresentor", package.seeall)

local ShowDownQualifyMatchViewPresentor = class("ShowDownQualifyMatchViewPresentor", ViewWithGuidePresentor)

function ShowDownQualifyMatchViewPresentor:ctor()
	ShowDownQualifyMatchViewPresentor.super.ctor(self)
end

function ShowDownQualifyMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShowDownQualifyMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownqualifymatchview.prefab"
	}
end

function ShowDownQualifyMatchViewPresentor:buildViews()
	return {
		ShowDownQualifyMatchView.New()
	}
end

return ShowDownQualifyMatchViewPresentor
