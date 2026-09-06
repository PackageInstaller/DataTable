-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessteamViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguessteamViewPresentor", package.seeall)

local DrawandguessteamViewPresentor = class("DrawandguessteamViewPresentor", ViewPresentor)

function DrawandguessteamViewPresentor:ctor()
	DrawandguessteamViewPresentor.super.ctor(self)
end

function DrawandguessteamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DrawandguessteamViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguessteamview.prefab"
	}
end

function DrawandguessteamViewPresentor:buildViews()
	return {
		DrawandguessteamView.New()
	}
end

return DrawandguessteamViewPresentor
