-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkSetTeamViewPresentor.lua

module("logic.extensions.elementspark.view.ElementSparkSetTeamViewPresentor", package.seeall)

local ElementSparkSetTeamViewPresentor = class("ElementSparkSetTeamViewPresentor", ViewPresentor)

function ElementSparkSetTeamViewPresentor:ctor()
	ElementSparkSetTeamViewPresentor.super.ctor(self)
end

function ElementSparkSetTeamViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ElementSparkSetTeamViewPresentor:dependWhatResources()
	return {
		"ui/views/elementspark/elementsparksetteamview.prefab"
	}
end

function ElementSparkSetTeamViewPresentor:buildViews()
	return {
		ElementSparkSetTeamView.New()
	}
end

return ElementSparkSetTeamViewPresentor
