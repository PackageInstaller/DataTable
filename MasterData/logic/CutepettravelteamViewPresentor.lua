-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/travel/CutepettravelteamViewPresentor.lua

module("logic.extensions.cutepet.view.CutepettravelteamViewPresentor", package.seeall)

local CutepettravelteamViewPresentor = class("CutepettravelteamViewPresentor", ViewPresentor)

function CutepettravelteamViewPresentor:ctor()
	CutepettravelteamViewPresentor.super.ctor(self)
end

function CutepettravelteamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function CutepettravelteamViewPresentor:dependWhatResources()
	return {
		"ui/views/cutepet/cutepettravelteamview.prefab"
	}
end

function CutepettravelteamViewPresentor:buildViews()
	return {
		CutepettravelteamView.New()
	}
end

return CutepettravelteamViewPresentor
