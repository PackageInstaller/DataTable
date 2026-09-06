-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguesscurteamViewPresentor.lua

module("logic.extensions.drawandguess.view.DrawandguesscurteamViewPresentor", package.seeall)

local DrawandguesscurteamViewPresentor = class("DrawandguesscurteamViewPresentor", ViewPresentor)

function DrawandguesscurteamViewPresentor:ctor()
	DrawandguesscurteamViewPresentor.super.ctor(self)
end

function DrawandguesscurteamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function DrawandguesscurteamViewPresentor:dependWhatResources()
	return {
		"ui/views/drawandguess/drawandguesscurteamview.prefab"
	}
end

function DrawandguesscurteamViewPresentor:buildViews()
	return {
		DrawandguesscurteamView.New()
	}
end

return DrawandguesscurteamViewPresentor
