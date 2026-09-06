-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowDownFinalFmtAdjustViewPresentor.lua

module("logic.extensions.showdown.view.ShowDownFinalFmtAdjustViewPresentor", package.seeall)

local ShowDownFinalFmtAdjustViewPresentor = class("ShowDownFinalFmtAdjustViewPresentor", ViewPresentor)

function ShowDownFinalFmtAdjustViewPresentor:ctor()
	ShowDownFinalFmtAdjustViewPresentor.super.ctor(self)
end

function ShowDownFinalFmtAdjustViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ShowDownFinalFmtAdjustViewPresentor:dependWhatResources()
	return {
		"ui/views/showdown/showdownfinalfmtadjustview.prefab"
	}
end

function ShowDownFinalFmtAdjustViewPresentor:buildViews()
	return {
		ShowDownFinalFmtAdjustView.New()
	}
end

return ShowDownFinalFmtAdjustViewPresentor
