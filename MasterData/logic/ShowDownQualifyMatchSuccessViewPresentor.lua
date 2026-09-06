-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownQualifyMatchSuccessViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownQualifyMatchSuccessViewPresentor", package.seeall)

local ShowDownQualifyMatchSuccessViewPresentor = class("ShowDownQualifyMatchSuccessViewPresentor", ViewWithGuidePresentor)

function ShowDownQualifyMatchSuccessViewPresentor:ctor()
	ShowDownQualifyMatchSuccessViewPresentor.super.ctor(self)
end

function ShowDownQualifyMatchSuccessViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ShowDownQualifyMatchSuccessViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownqualifymatchsuccessview.prefab"
	}
end

function ShowDownQualifyMatchSuccessViewPresentor:buildViews()
	return {
		ShowDownQualifyMatchSuccessView.New()
	}
end

return ShowDownQualifyMatchSuccessViewPresentor
