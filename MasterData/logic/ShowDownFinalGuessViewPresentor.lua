-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalGuessViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownFinalGuessViewPresentor", package.seeall)

local ShowDownFinalGuessViewPresentor = class("ShowDownFinalGuessViewPresentor", ViewPresentor)

function ShowDownFinalGuessViewPresentor:ctor()
	ShowDownFinalGuessViewPresentor.super.ctor(self)
end

function ShowDownFinalGuessViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownFinalGuessViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownfinalguessview.prefab"
	}
end

function ShowDownFinalGuessViewPresentor:buildViews()
	return {
		ShowDownFinalGuessView.New()
	}
end

return ShowDownFinalGuessViewPresentor
