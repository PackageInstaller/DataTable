-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkSelectTeamViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkSelectTeamViewPresentor", package.seeall)

local ElementSparkSelectTeamViewPresentor = class("ElementSparkSelectTeamViewPresentor", ViewPresentor)

function ElementSparkSelectTeamViewPresentor:ctor()
	ElementSparkSelectTeamViewPresentor.super.ctor(self)
end

function ElementSparkSelectTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function ElementSparkSelectTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparkselectteamview.prefab"
	}
end

function ElementSparkSelectTeamViewPresentor:buildViews()
	return {
		ElementSparkSelectTeamView.New()
	}
end

return ElementSparkSelectTeamViewPresentor
